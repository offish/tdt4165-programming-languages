object TransactionStatus extends Enumeration {
  val SUCCESS, PENDING, FAILED = Value
}

class TransactionPool {
  // Data structure to hold transactions - use the built in function to implement the
  // methods in TransactionPool
  private var transactions : ParSeq[Transaction] = ParSeq.empty[Transaction]
  
  def getTransactions(status: TransactionStatus.Value) : List[Transaction] = {
    transactions.filter(_.getStatus == status).toList
  }

  // Remove and the transaction from the pool
  def remove(t: Transaction): Boolean = this.synchronized {
    if (transactions.exists(_ == t)) {
      transactions = transactions.filterNot(_ == t)
      true
    } else {
      false
    }
  }
  // Return whether the queue is empty
  def isEmpty: Boolean = {
    transactions.isEmpty
  }

  // Return the size of the pool
  def size: Integer = {
    transactions.size
  }

  // Add new element to the back of the queue
  def add(t: Transaction): Boolean = this.synchronized {
    if (!transactions.exists(_ == t)) {
      transactions = transactions :+ t
      true
    } else {
      false
    }
  }
  // Return an iterator to allow you to iterate over the queue
  def iterator : Iterator[Transaction] = {
    transactions.toIterator
  }
}

class Transaction(val from: String, val to: String, val amount: Double, val retries: Int = 3) {
  private var status: TransactionStatus.Value = TransactionStatus.PENDING
  private var attempts = 0
  
  def isRetry() : Boolean = {
    return attempts < retries
  }
  
  def getStatus() = status
  
  // change the status of the transaction
  def setStatus(newStatus: TransactionStatus.Value) : Unit = synchronized {
    status = newStatus
  }

  def incrementAttempts() : Unit = synchronized {
    attempts += 1
  }

  override def toString: String = {
    s"Transaction(from: $from, to: $to, amount: $amount, retries: " +
    s"$retries, status: $status, attempts: $attempts)"
  }
}
