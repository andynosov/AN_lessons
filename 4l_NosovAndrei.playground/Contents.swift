import Foundation

class Car {
    var brand: String
    var year: Int
    var doorState: DoorAction
    var engineState: EngineAction
    var anAction: SomeActions
    
    
    enum DoorAction: String {
        case open = "Doors are open"
        case closed = "Doors are closed"
    }
    
    enum EngineAction: String {
        case on = "engine is On"
        case off = "engine is Off"
    }
    
    enum SomeActions: String {
        case on
        case off
    }
    
    
    enum CarActions {
        case actionWithDoor (DoorAction)
        case actionWithEngine (EngineAction)
        case someActions (SomeActions, Double)
    }
    
    func generalCarAction (action: CarActions) {
        switch action {
        case .actionWithDoor (let changingParameter):
            self.doorState = changingParameter
            print(changingParameter.rawValue)
        case .actionWithEngine(let changingParameter):
            self.engineState = changingParameter
            print(changingParameter.rawValue)
        case let .someActions(changingParameter, _):
            switch changingParameter {
            case .on, .off : print("feature is not available for your car model")
            }
        }
    }
    init(enterBrand: String, yearToCall: Int, doorsStateToCall: DoorAction, engineStateToCall: EngineAction, someActionToCall: SomeActions) {
        brand = enterBrand
        year = yearToCall
        doorState = doorsStateToCall
        engineState = engineStateToCall
        anAction = someActionToCall
    }
} // class Car end


class SportCar:Car {
    var suspensionHeight: Double
    var maxSuspensionHeight : Double
    
    private func suspensionMode (inches: Double){
        if inches > maxSuspensionHeight  || inches < 0 {
            print("alarm! incorrect action")
        } else {
            if inches < suspensionHeight {
                suspensionHeight = inches
                print("car is down, actual suspension height is \(suspensionHeight)in")
            } else {
                suspensionHeight = inches
                print("car is up, actual suspension height is \(suspensionHeight)in")
            }
        }
    }
    
    
    override func generalCarAction(action: CarActions) {
        switch action {
        case .actionWithDoor (let changingParameter):
            self.doorState = changingParameter
            print(changingParameter.rawValue)
        case .actionWithEngine(let changingParameter):
            self.engineState = changingParameter
            print(changingParameter.rawValue)
        case let .someActions(changingParameter, number):
            switch changingParameter {
            case .on : suspensionMode(inches: number)
            case .off : print("standard road mode")
            }
        }
    }
    
    
    init(enterSportCarBrand: String, yearToCall: Int, doorsStateToCall: DoorAction, engineStateToCall: EngineAction,  callForSuspension: Double, callForMaxSuspension: Double, someActionToCall: SomeActions) {
        maxSuspensionHeight = callForMaxSuspension
        suspensionHeight = callForSuspension
        super.init(enterBrand: enterSportCarBrand, yearToCall: yearToCall, doorsStateToCall: doorsStateToCall, engineStateToCall: engineStateToCall, someActionToCall: someActionToCall)
    }
}// class SportCar end



var alphaRomeo = SportCar(enterSportCarBrand: "Alpha Romeo", yearToCall: 2021, doorsStateToCall: .open, engineStateToCall: .on, callForSuspension: 0, callForMaxSuspension: 10, someActionToCall: .off)
alphaRomeo.generalCarAction(action: .someActions(.on, 8))

var vaz = Car(enterBrand: "VAZ", yearToCall: 1990, doorsStateToCall: .closed, engineStateToCall: .off, someActionToCall: .on)
vaz.generalCarAction(action: .someActions(.off, 1))
alphaRomeo.generalCarAction(action: .someActions(.on, 11))
alphaRomeo.suspensionHeight
alphaRomeo.generalCarAction(action: .someActions(.on, 7))




class TrunkCar: Car {
    
    var maxBodyVolume: Double
    var availableBodyVolume: Double {
       return maxBodyVolume - goodsVolumeStored
    }
    var goodsVolumeStored: Double
    
    init(enterTrunkCarBrand:String, yearToCall:Int, doorStateToCall: DoorAction, engineStateToCall: EngineAction, someActionToCall: SomeActions, maxBodyVolumeToCall: Double,  goodsVolumeStoredCall: Double){
        maxBodyVolume = maxBodyVolumeToCall
        goodsVolumeStored = goodsVolumeStoredCall
        super.init(enterBrand: enterTrunkCarBrand, yearToCall: yearToCall, doorsStateToCall: doorStateToCall, engineStateToCall: engineStateToCall, someActionToCall: someActionToCall)
    }
    
    
    private func addGoods (volume: Double) {
        if volume + goodsVolumeStored <= maxBodyVolume  {
            goodsVolumeStored +=  volume
            print ("\(volume) m3 stored, free space is \(availableBodyVolume) ")
        } else {
            print ("load limit alarm")
        }
    }
    private func removeGoods(volume: Double) {
        if goodsVolumeStored - volume >= 0  {
            goodsVolumeStored -=  volume
            print ("\(volume) m3 removed, occupied volume is \(goodsVolumeStored) m3 ")
        } else {
            print ("volume of \(volume) m3 cannot be removed, occupied volume is \(goodsVolumeStored) m3")
        }
    }
    
    override func generalCarAction(action: CarActions) {
        switch action {
        case .actionWithEngine(let parameter):
            print(parameter.rawValue)
        case .actionWithDoor(let parameter):
            print(parameter.rawValue)
        case let .someActions(parameter, volume):
            if parameter == .on {
                addGoods(volume: volume)
            } else {
                removeGoods(volume: volume)
            }
        }
    }
    
    
    
    
}// class TrunkCar end


var scania = TrunkCar(enterTrunkCarBrand: "scania", yearToCall: 1999, doorStateToCall: .closed, engineStateToCall: .on, someActionToCall: .off, maxBodyVolumeToCall: 10000, goodsVolumeStoredCall: 0)

scania.generalCarAction(action: .actionWithDoor(.closed))
scania.generalCarAction(action: .someActions(.off, 0))
scania.generalCarAction(action: .someActions(.off, 1))
scania.generalCarAction(action: .someActions(.on, 9999))
scania.generalCarAction(action: .someActions(.on, 1))
scania.generalCarAction(action: .someActions(.on, 1))
scania.generalCarAction(action: .someActions(.off, 9999))
scania.generalCarAction(action: .someActions(.off, 2))
