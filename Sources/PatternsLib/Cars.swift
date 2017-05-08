//
//  Cars.swift
//  Patterns
//
//  Created by viwii on 2017/5/5.
//
//
// 抽象工厂模式

import Foundation

enum EngineOption {
    case front, mid
}
protocol FloorPlan {
    var seats: Int { get }
    var enginePosition: EngineOption { get }
}

class ShortFloorPlan: FloorPlan {
    var seats: Int = 2
    var enginePosition: EngineOption = .mid
}

class StandardFloorPlan: FloorPlan {
    var seats: Int = 4
    var enginePosition: EngineOption = .front
}

class LongFloorPlan: FloorPlan {
    var seats: Int = 8
    var enginePosition: EngineOption = .front
}


enum SuspensionOption {
    case standard, sports, soft
}

protocol Suspension {
    var type: SuspensionOption { get }
}

class RoadSuspension: Suspension {
    var type: SuspensionOption = .standard
}

class OffRoadSuspension: Suspension {
    var type: SuspensionOption = .soft
}

class RaceSuspension: Suspension {
    var type: SuspensionOption = .sports
}


enum DriveOption {
    case front, rear, all
}

protocol DriveTrain {
    var type: DriveOption { get }
}

class FrontWheelDrive: DriveTrain {
    var type: DriveOption = .front
}

class RearWheelDrive: DriveTrain {
    var type: DriveOption = .rear
}

class AllWheelDrive: DriveTrain {
    var type: DriveOption = .all
}


public enum Cars {
    case compact
    case sports
    case suv
}

public struct Car {
    var type: Cars
    var floor: FloorPlan
    var suspension: Suspension
    var drive: DriveTrain
    
    var description: String {
        return "<Car: \ntype - \(type)\nseats - \(floor.seats)\nengine - \(floor.enginePosition)\nsuspension - \(suspension)\ndrive - \(drive)\n >"
    }
    
    init(type: Cars, floor: FloorPlan, suspension: Suspension, drive: DriveTrain) {
        self.type       = type
        self.floor      = floor
        self.suspension = suspension
        self.drive      = drive
    }
    
    // 抽象工厂模式变体 - 隐藏抽象工厂类
    
    init(car: Cars) {
        let f = CarFactory.make(car)
        
        type        = car
        floor       = f.makeFloorPlan()
        suspension  = f.makeSuspension()
        drive       = f.makeDriveTrain()
    }
}




public class CarFactory {
    
    fileprivate init() {}
    
    func makeFloorPlan() -> FloorPlan {
        fatalError()
    }
    func makeSuspension() -> Suspension {
        fatalError()
    }
    func makeDriveTrain() -> DriveTrain {
        fatalError()
    }
    
    final public class func make(_ car: Cars) -> CarFactory {
        switch car {
        case .compact:
            return CompactCarFactory()
        case .sports:
            return SportsCarFactory()
        case .suv:
            return SUVCarFactory()
        }
    }
}


fileprivate class CompactCarFactory: CarFactory {
    override func makeFloorPlan() -> FloorPlan {
        return StandardFloorPlan()
    }
    override func makeDriveTrain() -> DriveTrain {
        return FrontWheelDrive()
    }
    override func makeSuspension() -> Suspension {
        return RoadSuspension()
    }
}

fileprivate class SportsCarFactory: CarFactory {
    override func makeFloorPlan() -> FloorPlan {
        return ShortFloorPlan()
    }
    override func makeDriveTrain() -> DriveTrain {
        return RearWheelDrive()
    }
    override func makeSuspension() -> Suspension {
        return RaceSuspension()
    }
}

fileprivate class SUVCarFactory: CarFactory {
    override func makeFloorPlan() -> FloorPlan {
        return LongFloorPlan()
    }
    override func makeDriveTrain() -> DriveTrain {
        return AllWheelDrive()
    }
    override func makeSuspension() -> Suspension {
        return OffRoadSuspension()
    }
}


