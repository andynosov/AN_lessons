//
//  main.swift
//  1I_NosovAndrei
//
//  Created by Andrei Nosov on 03.11.2021.
//

import Foundation

//1. Решить квадратное уравнение.

var a: Int = 2
var b: Int = 10
var c: Int = 3
var x1: Double
var x2: Double
var d: Double

d = Double((b * b) - (4 * a * c))

if d == 0 {
    x1 = Double((-b) / (2 * a))
    print ("один корень x1 = \(x1)")
}
else if d > 0 {
    x1 = (Double(-b) - sqrt(d)) / Double(2 * a)
    x2 = (Double(-b) + sqrt(d)) / Double(2 * a)
    print ("x1 = \(x1)")
    print ("x2 = \(x2)")
}
else {
    print ("корней нет")
}

//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

var katet1: Int = 20
var katet2: Int = 15
var s: Double
var petimetr: Double
var gippotenuza: Double

s = Double(katet1 * katet2 / 2)
gippotenuza = sqrt(Double(katet1 * katet1) + Double(katet2 * katet2))
petimetr =  Double(katet1 + katet2) + gippotenuza
print("Площадь = \(s), Гиппотенуза = \(gippotenuza), Периметр = \(petimetr)")




//3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.




print("введите сумму дипозита: ")
var depositSum = Double(readLine()!)
print("введите процент по вкладу: ")
var percent = Double(readLine()!)
var years: Double = 5.0
var finalDeposit: Double


if depositSum != nil && percent != nil {
    finalDeposit  = depositSum! + ((depositSum! * (percent! / 100.0)) * 5)
    print("Сумма на вашем счету через \(Int(years)) лет: \(finalDeposit)")
}
else {
    print("incorrect input")
}
