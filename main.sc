// Task 1a
val array = (for (i <- 1 to 50) yield i).toArray
println(array)

// Task 1b
def sumArray(array: Array[Int]): Int = {
  var sum = 0

  for (i <- 0 until array.length) {
    sum += array(i)
  }

  sum
}

println(sumArray(array))

// Task 1c
def sumArrayRecursive(array: Array[Int], index: Int = 0): Int = {
  if (index == array.length)
    0
  else
    array(index) + sumArrayRecursive(array, index + 1)
}

println(sumArrayRecursive(array))

// Task 1d
def fibonacci(n: Int): BigInt = {
  if (n == 0)
    0
  else if (n == 1)
    1
  else
    fibonacci(n - 1) + fibonacci(n - 2)
}

println(fibonacci(10))

// Task 2
def quadraticEquation(a: Double, b: Double, c: Double): (Boolean, Double, Double) = {
  val delta = b * b - 4 * a * c

  if (delta < 0)
    (false, 0, 0)
  else
    val x1 = (-b + Math.sqrt(delta)) / (2 * a)
    val x2 = (-b - Math.sqrt(delta)) / (2 * a)
    (true, x1, x2)
}

def quadratic(a: Double, b: Double, c: Double): Double => Double = {
  (x: Double) => a * x * x + b * x + c
}

println(quadraticEquation(2, 1, 2))
println(quadraticEquation(2, 1, -1))
println(quadratic(2, 1, -1)(2))

// Task 3a
def createThread(task: () => Unit): Thread = {
  new Thread {
    override def run(): Unit = task()
  }
}

// Task 3b
object ConcurrencyTroubles {
  private var value1: Int = 1000
  private var value2: Int = 0
  private var sum: Int = 0

  def moveOneUnit(): Unit = {
    value1 -= 1;
    value2 += 1;
    if(value1 == 0) {
      value1 = 1000;
      value2 = 0;
    }
  }
  
  def updateSum(): Unit = {
    sum = value1 + value2;
  }

  def execute(): Unit = {
    while true do
      moveOneUnit();
      updateSum();
      Thread.sleep(100)
  }

  // This is the "main" method, the entry point of execution.
  // It could have been placed in a different file.
  @main def main(args: String*): Unit =

  for (i <- 1 to 2) {
    val thread = new Thread {
      override def run = execute()
    }
    
    thread.start()
  }

  while(true) {
    updateSum();
    println(sum + " [" + value1 + " " + value2 + "]");
  }
}
