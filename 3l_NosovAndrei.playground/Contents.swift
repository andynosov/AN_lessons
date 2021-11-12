import Foundation

//Домашнее задание
//Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//Вывести значения свойств экземпляров в консоль.



struct SportCar {
    
    var name: String
    let year: Int
    var windowsStatus: WindowsStatus
    var engineStatus: EngineStatus
    let trunkVolume: Double
    var actualGoodsVolume: Double
    var avialableTrunkVolume: Double {
        return trunkVolume - actualGoodsVolume
    }
    
    
    
    enum EngineStatus: String {
        case engineOn  = "Двигатель включен"
        case engineOff = "Двигатель выключен"
    }
    
    enum WindowsStatus: String {
        case windowsOpen = "Окна открыты"
        case windowsClose = "Окна закрыты"
    }
    
    enum TrunkActions {
        case add
        case remove
    }
    
    enum sportCarActions {
        case windowsActions(WindowsStatus)
        case engineActions(EngineStatus)
        case changeTrunkVolume(TrunkActions, Double)
    }
    
    
    
    //инициализация внутри структуры
    
    init(model: String, yearOfProduction: Int, trunkVolume: Double, takenTrunkVolume: Double) {
        self.year = yearOfProduction
        self.name = model
        self.trunkVolume = trunkVolume
        self.actualGoodsVolume = 0.0        //как начальные параметры новой машины
        self.engineStatus = .engineOff    //как начальные параметры новой машины
        self.windowsStatus = .windowsClose //как начальные параметры новой машины
        
    }
    
    
    
    //Добавить в структуры МЕТОД с ОДНИМ аргументом типа перечисления, который будет менять ВСЕ свойства структуры в зависимости от действия.
    
    mutating private func addGoods(goodsVolume: Double) {   // для внутреннего использования
        if actualGoodsVolume + goodsVolume > trunkVolume {
            print("груз объемом \(goodsVolume) не поместится. Заполненный объем \(actualGoodsVolume)")
        } else {
            actualGoodsVolume += goodsVolume
            print("выгружено \(goodsVolume), общий заполненный объем \(actualGoodsVolume)")
        }
    }
    
    mutating private func removeGoods(goodsVolume: Double) { // для внутреннего использования
        if actualGoodsVolume - goodsVolume < 0 {
            print("значение выгружаемого багажа больше имеющегося")
        } else if actualGoodsVolume - goodsVolume == 0 {
            print("багажник пуст")
        } else {
            actualGoodsVolume -= goodsVolume
            print("загружено \(goodsVolume), общий заполненный объем \(actualGoodsVolume)")
        }
    }
    
    
    mutating func changeCarState (action: sportCarActions)  {
        
        switch action {
        case .windowsActions(let parameter):
            self.windowsStatus = parameter
            print(parameter.rawValue)
        case .engineActions(let parameter):
            self.engineStatus = parameter
            print(parameter.rawValue)
        case let .changeTrunkVolume(action, volume):
            switch action {
            case .add : addGoods(goodsVolume: volume)
            case .remove: removeGoods(goodsVolume: volume)
            }
            
            
            
        }
    }
    
}

var volvoCar = SportCar(model: "VOLVO", yearOfProduction: 1999, trunkVolume: 10.0, takenTrunkVolume: 0.0)

volvoCar.engineStatus
volvoCar.windowsStatus
volvoCar.changeCarState(action: .engineActions(.engineOn))
volvoCar.changeCarState(action: .windowsActions(.windowsOpen))
volvoCar.changeCarState(action: .changeTrunkVolume(.remove, 10))
volvoCar.actualGoodsVolume
volvoCar.changeCarState(action: .changeTrunkVolume(.add, 20))
volvoCar.changeCarState(action: .changeTrunkVolume(.add, 10))
volvoCar.changeCarState(action: .changeTrunkVolume(.remove, 15))
volvoCar.changeCarState(action: .changeTrunkVolume(.remove, 5))
volvoCar.changeCarState(action: .changeTrunkVolume(.add, 3))



struct TrunkCar {
    
    var name: String
    var year: Int
    var engineState: EngineState
    var windowsState: WindowsState
    let maxBodyVolume: Double
    var actualGoodsVolume: Double
    var availableBodyVolume: Double {
        return maxBodyVolume - actualGoodsVolume
    }
    
    
    enum EngineState: String {
        case on = "engine is on"
        case off = "engine is off"
    }
    
    enum WindowsState: String {
        case on = "windows is open"
        case off = "windows is closed"
    }
    
    
    enum ActionsWithBody {
        case add
        case remove
        
    }
    
    enum CarActions {
        case engineActions (EngineState)
        case windowsActions (WindowsState)
        case actionsWithGoods (ActionsWithBody, Double)
        
        
    }
    
    
    
    mutating func actionsWithTrunkCar (action: CarActions) {
        switch action {
        case .windowsActions(let action):
            print(action.rawValue)
        case .engineActions(let action):
            print(action.rawValue)
        case .actionsWithGoods(let action, let volume):
            switch action {
            case .add:
                if volume + actualGoodsVolume <= maxBodyVolume {
                    actualGoodsVolume += volume
                    print("\(volume) added")
                } else {print("load limit alarm")}
            case .remove:
                if volume > actualGoodsVolume {
                    print("incorrect volume to remove ")
                } else{
                    actualGoodsVolume -= volume
                    print("\(volume) removed, actual goods Volume is \(actualGoodsVolume)")
                }
            }
        }
    }
}

var scania = TrunkCar(name: "Scania", year: 2020, engineState: .off, windowsState: .off, maxBodyVolume: 1000.0, actualGoodsVolume: 0.0)

scania.engineState
scania.actionsWithTrunkCar(action: .actionsWithGoods(.add, 1000.0))
scania.actualGoodsVolume
scania.availableBodyVolume
scania.actionsWithTrunkCar(action: .windowsActions(.on))
scania.actionsWithTrunkCar(action: .actionsWithGoods(.add, 1.0))
scania.actionsWithTrunkCar(action: .actionsWithGoods(.remove, 999.0))
scania.actionsWithTrunkCar(action: .actionsWithGoods(.remove, 2.0))
