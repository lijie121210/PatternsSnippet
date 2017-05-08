//
//  RentalCar.swift
//  Patterns
//
//  Created by viwii on 2017/5/5.
//
//

import Foundation

public class RentalCar {
    private(set) var name : String
    private(set) var passengers : Int
    private(set) var price: Float
    
    fileprivate init(name: String, passengers: Int, price: Float) {
        self.name = name
        self.passengers = passengers
        self.price = price
    }
    
    public class func make(passengers: Int) -> RentalCar? {
        var car: RentalCar.Type?
        switch passengers {
        case 0...3:
            car = Compact.self
        case 4...8:
            car = SUV.self
        default:
            car = nil
        }
        return car?.make(passengers: passengers)
    }
}

public class Compact: RentalCar {
    fileprivate override init(name: String, passengers: Int, price: Float) {
        super.init(name: name, passengers: passengers, price: price)
    }
    
    fileprivate convenience init() {
        self.init(name: "VM Golf", passengers: 3, price: 20)
    }
    
    public override class func make(passengers: Int) -> RentalCar? {
        if passengers < 2 {
            return SmallCompact()
        } else {
            return Compact()
        }
    }
}

public class SmallCompact: Compact {
    fileprivate init() {
        super.init(name: "Ford Fiesta", passengers: 3, price: 15)
    }
}

public class SUV: RentalCar {
    private init() {
        super.init(name: "Cadillac Escalade", passengers: 8, price: 75)
    }
    
    public override class func make(passengers: Int) -> RentalCar? {
        return SUV()
    }
}
