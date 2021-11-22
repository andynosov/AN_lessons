import Foundation

//Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//*Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.





//Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.

protocol AgesCompair {
    var age: Int {get set}
    var name: String {get set}
}

class Clients:AgesCompair{
    var age: Int
    var name: String
    var yob: Int
    private var currentYear: Int = 2021
    init(name: String, yearOfBitrh: Int) {
        yob = yearOfBitrh
        self.age = currentYear - yob
        self.name = name
    }
}

struct GeneralList<T: AgesCompair > {
    var list: [T]=[]
    mutating func push(client:T){
        list.append(client)
    }
    mutating func pop()-> T? {
        guard list.count > 0 else {return nil}
        return list.removeLast()
    }
    
    //*Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
    
    subscript (index: Int) -> T? {
        get {
            guard index >= 0 && index < self.list.count else {
                return nil
            }
            return self.list[index]
        }
    }

}

var listOfClients = GeneralList<Clients>()

listOfClients.push(client: Clients(name: "John", yearOfBitrh: 1950))
listOfClients.push(client: Clients(name: "Terry", yearOfBitrh: 1940))
listOfClients.push(client: Clients(name: "Robert", yearOfBitrh: 1949))
listOfClients.push(client: Clients(name: "Zoye", yearOfBitrh: 1972))
listOfClients.push(client: Clients(name: "Ashley", yearOfBitrh: 1991))


//Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)

let allAboveFifty = listOfClients.list.filter() {$0.age >= 50}.map({$0.name.uppercased()})
print("all clients above 50: \(allAboveFifty)")


extension Clients: CustomStringConvertible {
    var description: String{
        return   ("\(name) is  \(age) y.o")
    }
}

print("all Clients: \(listOfClients.list)")


