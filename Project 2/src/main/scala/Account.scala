
class Account(val code : String, val balance: Double) {
  def withdraw(amount: Double) : Either[String, Account] = {
    /*
    Removes an amount of money from the account.

    The functions should fail if:
      - Amount is a negative
      - Amount is larger than the current balance
      
    Returns:
      Either: Account indicates sucess, otherwise a string 
        describing the failure.
      Right is used for success and Left for failure.
    */
    if (amount < 0) {
      return Left("The amount has to be a positive number")
    } else if (amount > balance) {
      return Left("The amount can not be greater than the balance")
    }

    val newBalance = balance - amount
    return Right(new Account(this.code, newBalance))
  }

  def deposit (amount: Double) : Either[String, Account] = {
    /*
    Inserts an amount of money to the account

    The functions should fail if:
      - Amount is negative
    
    Returns:
      Either: Account indicates sucess, otherwise a string
        describing the failure
      Right is used for success and Left for failure.
    */
    if (amount < 0) {
      return Left("The amount has to be a positive number")
    }

    val newBalance = balance + amount
    return Right(new Account(this.code, newBalance))
  }
}
