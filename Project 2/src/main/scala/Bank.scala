import collection.mutable.Map
import java.util.UUID
import java.util.concurrent.locks.ReentrantLock

class Bank(val allowedAttempts: Integer = 3) {
  private var accountsRegistry: Map[String, Account] = Map()
  private val accountLockRegistry: Map[String, Object] = Map()
  private val accountsRegistryLock: Object = new Object
  val transactionsPool: TransactionPool = new TransactionPool()
  val completedTransactions: TransactionPool = new TransactionPool()
  
  def processing: Boolean = !transactionsPool.isEmpty
  
  // Adds a new transaction for the transfer to the transaction pool
  def transfer(from: String, to: String, amount: Double): Unit = {
    transactionsPool.add(new Transaction(from, to, amount))
  }

  // Process the transactions in the transaction pool
  def processTransactions: Unit = {
    val workers: List[Thread] = transactionsPool
      .iterator
      .toList
      .filter(_.getStatus() == TransactionStatus.PENDING)
      .map(processSingleTransaction)
    
    workers.foreach(_.start())
    workers.foreach(_.join())
    // Handle succeeded transactions
    val succeeded: List[Transaction] = transactionsPool.getTransactions(TransactionStatus.SUCCESS)
    
    succeeded.foreach(transactionsPool.remove)
    succeeded.foreach(completedTransactions.add)
    
    // Handle failed transactions
    val failed: List[Transaction] = transactionsPool.getTransactions(TransactionStatus.FAILED)
    
    failed.foreach { t =>
      if (t.isRetry()) {
        t.setStatus(TransactionStatus.PENDING)
      } else {
        if (transactionsPool.remove(t)) {
          completedTransactions.add(t)
        }
      }
    }
    if (!transactionsPool.isEmpty) {
      processTransactions
    }
  }

  private def processSingleTransaction(t: Transaction): Thread = {
    new Thread(new Runnable {
      override def run(): Unit = {
        // Determine lock order based on account IDs
        val (firstLock, secondLock) =
          if (t.from < t.to)
            (accountLockRegistry(t.from),
            accountLockRegistry(t.to))
          else
            (accountLockRegistry(t.to),
            accountLockRegistry(t.from))

        firstLock.synchronized {
          secondLock.synchronized {
            val fromAccount = accountsRegistry.getOrElse(
              t.from,
              throw new NoSuchElementException(s"Account not found for ${t.from}")
            )

            val toAccount = accountsRegistry.getOrElse(
              t.to,
              throw new NoSuchElementException(s"Account not found for ${t.to}")
            )
          
            fromAccount.withdraw(t.amount) match {
              case Left(_) =>
              t.setStatus(TransactionStatus.FAILED)
              t.incrementAttempts
              case Right(updatedFromAccount) => toAccount.deposit(t.amount) match {
                case Left(_) =>
                t.setStatus(TransactionStatus.FAILED)
                t.incrementAttempts
                case Right(updatedToAccount) =>
                t.setStatus(TransactionStatus.SUCCESS)
                accountsRegistryLock.synchronized
                {
                  accountsRegistry = accountsRegistry.updated(t.from, updatedFromAccount)
                  accountsRegistry = accountsRegistry.updated(t.to,updatedToAccount)
                }
              }
            }
          }
        }
      }
    })
  }
  // Creates a new account and returns its code
  def createAccount(initialBalance: Double): String = {
    val code = UUID.randomUUID().toString()
    val account = new Account(code, initialBalance)
    accountsRegistry.put(code, account)
    accountLockRegistry.put(code, new Object)
    code
  }

  // Return information about a certain account based on its code
  def getAccount(code: String): Option[Account] = {
    accountsRegistry.get(code)
  }
}