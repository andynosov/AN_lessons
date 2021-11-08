import Foundation



//1. Написать функцию, которая определяет, четное число или нет.

func oddCheck (_ number: Int)  -> Bool {
    return number % 2 == 0 ? true : false
}

print(oddCheck(5))
print(oddCheck(44))




//2.Написать функцию, которая определяет, делится ли число без остатка на 3.
func dividedByThree(_ number: Int) -> Bool {
    return number % 3 == 0 ? true: false
}

print(dividedByThree(33))
print(dividedByThree(27))
print(dividedByThree(8))


//3. Создать возрастающий массив из 100 чисел. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

func notDividedByThree(_ number: Int) -> Bool {
    return number % 3 != 0 ? true: false
}

func removeFromArray1 (from: Int, to: Int) -> [Int] {
    var array = [Int]()
    for i in from...to {
        array.append(i)
    }
    array.removeAll(where: oddCheck)
    array.removeAll(where: notDividedByThree)
    return array
}

        
var array1 = removeFromArray1(from: 0, to: 99)
print ("array1 w/o odd numbers and numbers devided by 3: \(array1)")

//* Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.

func fibbonacchiNumbers (_ array: inout [Int]) -> [Int]{
    for _ in 1...50 {
        array.append(array[array.count - 1] + array[array.count - 2])
    }
    return array
}


array1 = fibbonacchiNumbers(&array1)
print("fibonnachi numbers = \(array1)")

//* Заполнить массив элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n (пусть будет 100), следуя методу Эратосфена, нужно выполнить следующие шаги:
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2 * p до n, считая шагом p.

func eratospheneFilter (n: Int) -> [Int] {
    var p = 2
    let n = n
    var newArray = [Int]()
    for i in p...n {
            newArray.append(i)
        }
    
    while p != newArray.last {
        for i in stride(from: 2 * p , through: newArray.last!, by: p) {
            guard let index = newArray.firstIndex(of: i) else {continue}
            newArray.remove(at: index)
        }
        guard let newFirst = newArray.first(where: { $0 > p  }) else {break}
        p = newFirst
    }
    
    
    return newArray
}

print("Final result of eratosphene Filter = \(eratospheneFilter(n: 100))")



