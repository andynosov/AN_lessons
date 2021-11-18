import Cocoa
import Foundation
//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//
//6. Вывести сами объекты в консоль.


enum DoorsActions: String {
    case on = "doors are opened"
    case off = "doors are closed"
}

enum EngineActions: String {
    case on = "engine is on"
    case off = "engine is off"
}

protocol Car {
    var name: String {get}
    var year: Int {get}
    var doorState: DoorsActions {get set}
    var engineState: EngineActions {get set }
    func describeCar()
}


//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).



extension  Car {
    
    mutating func carDoorsAction (anAction: DoorsActions){
        if anAction == .on {
            self.doorState = .on
        } else {
            self.doorState = .off
        }
        print(doorState.rawValue)
    }
}


extension Car {
    mutating func engineAction(action: EngineActions){
        switch action{
        case .off:
            self.engineState = .off
            print(doorState.rawValue)
        case .on:
            self.engineState = .on
            print(doorState.rawValue)
        }
        
    }
}



//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

class SportCar: Car{

    var name: String
    var year: Int
    var maxSuspensionMode: Double
    var suspensionHeight: Double
    var doorState: DoorsActions
    var engineState: EngineActions
    
    init(enterName: String, enterYear: Int, enterMaxSuspension: Double, enterSuspensionHeight: Double, enterDoorState: DoorsActions, enterEngineState: EngineActions){
        name = enterName
        year = enterYear
        maxSuspensionMode = enterMaxSuspension
        suspensionHeight = enterSuspensionHeight
        doorState = .off
        engineState = .off
    }
    
    
    func describeCar()  {
        print( "car model \(name), year of release \(year)")
    }
    
}


var volvo = SportCar(enterName: "Volvo", enterYear: 1999, enterMaxSuspension: 10, enterSuspensionHeight: 0.0, enterDoorState: .off, enterEngineState: .off)


//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

extension SportCar: CustomStringConvertible{
    var description: String {
        get {
            return "Hello, owner of \(name)! Actual suspension settings are: \(suspensionHeight) inches, \(engineState.rawValue)"
        }
    }
}


class TrunkCar: Car{

    var name: String
    var year: Int
    var maxBodyCapacity: Double
    var actualBodyOccupied: Double
    var liftingBodyFeature: Bool
    var doorState: DoorsActions
    var engineState: EngineActions
    var statusOfLiftingFeature: String {
        if liftingBodyFeature == true {
            return "Your car is equipped with Liftig mechanism"
        } else {
            return "Your car is not equipped with Liftig mechanism"
        }
    }
    
    init(enterName: String, enterYear: Int, enterMaxBodyCapacity: Double, enterActualBodyOccupued: Double, isLiftingBodyFeature: Bool, enterDoorState: DoorsActions, enterEngineState: EngineActions){
        name = enterName
        year = enterYear
        maxBodyCapacity = enterMaxBodyCapacity
        actualBodyOccupied = enterActualBodyOccupued
        liftingBodyFeature = isLiftingBodyFeature
        doorState = enterDoorState
        engineState = enterEngineState
    }
    
    
    func describeCar() {
        print( "car model \(name), year of release \(year), \(statusOfLiftingFeature)")
    }
    
}

var scania = TrunkCar(enterName: "Scania", enterYear: 2010, enterMaxBodyCapacity: 1000.0, enterActualBodyOccupued: 200.0, isLiftingBodyFeature: true, enterDoorState: .off, enterEngineState: .off)
print(scania.describeCar())




extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Hello, owner of \(name)! Actual occupied Body volume : \(actualBodyOccupied) m3, \(engineState.rawValue),\(statusOfLiftingFeature), \(doorState.rawValue)"

    }
}

scania.engineAction(action: .on)
volvo.engineAction(action: .on)
scania.carDoorsAction(anAction: .on)
scania.describeCar()
volvo.describeCar()

print(scania)
print(volvo)

scania.carDoorsAction(anAction: .off)
print(scania)
