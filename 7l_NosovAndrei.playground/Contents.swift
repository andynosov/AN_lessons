import Foundation

//
//Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.



enum GasStationErrors: Error {
    
    case requestedUnknownFuelType
    case outOfStockError
    case lowBalance(need: Int)
}
struct FuelParams {
    var price: Int
    var actualAvailableFuel: Int
    var totalPrice:Int {
        price * actualAvailableFuel
    }
}


class GasStationApp {
    
    var clientWallet = 10000
    
    
    var pumpTag: [Int: FuelParams] = [
        98: FuelParams(price: 65, actualAvailableFuel: 80),
        95: FuelParams(price: 60, actualAvailableFuel: 100),
        100: FuelParams(price: 99, actualAvailableFuel: 70)
    ]
    
    func buy(fuelToFill fuel: Int, qty: Int) -> (FuelParams?, GasStationErrors?) {
        guard let requestedFuel  = pumpTag[fuel] else {
            return (nil, GasStationErrors.requestedUnknownFuelType)
        }
        
        guard requestedFuel.actualAvailableFuel > qty  else {
            return (nil, GasStationErrors.outOfStockError)
        }
        
        guard requestedFuel.totalPrice < clientWallet else {
            return(nil, GasStationErrors.lowBalance(need: requestedFuel.totalPrice - clientWallet))
        }
        
        clientWallet -= requestedFuel.totalPrice
        var newFuelData = requestedFuel
        newFuelData.actualAvailableFuel -= qty
        print("в колонке осталось \(newFuelData.actualAvailableFuel) литров \(fuel) бензина")
        print("запрошено \(qty) литров \(fuel) бензина стоимость за литр \(newFuelData.price) , списано \(requestedFuel.totalPrice)")
        print("балланс на карте: \(clientWallet)")
        pumpTag[fuel] = newFuelData
        return (newFuelData, nil)
    }
    
}

var newBuyer = GasStationApp()
newBuyer.buy(fuelToFill: 98, qty: 79)
newBuyer.buy(fuelToFill: 98, qty: 2)
newBuyer.buy(fuelToFill: 100, qty: 69)
newBuyer.buy(fuelToFill: 100, qty: 69)


//Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.


extension CarsElectricSystem: CustomStringConvertible {
    var description: String {
        return "sportmode: \(sportMode), suspension: \(suspensionHeight) in, transmission: \(transmission)"
    }
}

enum CarError: Error {
    case suspensionError
    case transmissionError
    
}


class CarsElectricSystem {
    var suspensionHeight = 0
    var sportMode: Bool
    var transmission: Int
    
    func carCatchError() throws {
        guard sportMode && suspensionHeight < 5 || sportMode == false else {
            throw CarError.suspensionError
        }
        guard sportMode == false && transmission < 7  || sportMode else {
            throw CarError.transmissionError
        }
    }
    init(suspensionHeight: Int, sportMode: Bool, transmission: Int) {
        self.suspensionHeight = suspensionHeight
        self.sportMode  = sportMode
        self.transmission = transmission
    }
    
}

print("===========car1==========")


var car1 = CarsElectricSystem(suspensionHeight: 10, sportMode: true, transmission: 5)

do {
    try car1.carCatchError()
    
} catch CarError.transmissionError {
    print ("ERROR: transmission 7+ blocked in regular drive mode")
    car1.transmission = 6
} catch CarError.suspensionError {
    print("ERROR: dangerous suspension height, mode changed to regular")
    car1.sportMode.toggle()
}

print(car1)



print("===========car2==========")

var car2 = CarsElectricSystem(suspensionHeight: 10, sportMode: false, transmission: 8)

do {
    try car2.carCatchError()
} catch CarError.transmissionError {
    print ("ERROR: transmission 7+ blocked in regular drive mode")
    car2.transmission = 6
} catch CarError.suspensionError {
    print("ERROR: dangerous suspension height, mode changed to regular")
    car2.sportMode.toggle()
}

print(car2)

print("==========car3===========")

var car3 = CarsElectricSystem(suspensionHeight: 5, sportMode: false, transmission: 5)

do {
    try car3.carCatchError()
} catch CarError.transmissionError {
    print("ERROR: transmission 7+ blocked in regular drive mode")
    car3.transmission = 6
} catch CarError.suspensionError {
    print("ERROR: dangerous suspension height, mode changed to regular")
    car3.sportMode.toggle()
}

print(car3)




enum AccountNumberErrors: Error{
    case tooShort
    case notANumbers
}



class UserAccount {

    var accountNumber: String
    
    init(enterAccountNumber: String){
        accountNumber = enterAccountNumber
    }

func checkAccountNumber(enterNumber pass: String ) throws -> Bool {

    guard pass.count >= 8 else {
        throw AccountNumberErrors.tooShort
    }
    guard Int(pass) != nil else {
        throw AccountNumberErrors.notANumbers
    }
    return true
 }
}



var user2124124 = UserAccount(enterAccountNumber: "123456f8")



do {
    try user2124124.checkAccountNumber(enterNumber: user2124124.accountNumber)
    print("ok, account number is checked")
} catch AccountNumberErrors.notANumbers {
    print("Only numbers allowed")
} catch AccountNumberErrors.tooShort {
    print("required account # lenght is 8")
}







    

