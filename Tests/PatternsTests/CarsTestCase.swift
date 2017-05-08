//
//  CarsTestCase.swift
//  Patterns
//
//  Created by viwii on 2017/5/5.
//
//

import XCTest

@testable import PatternsLib

class CarsTestCase: XCTestCase {
    
    static var allTests: [(String, (CarsTestCase) -> () throws -> Void)] {
        return [
            ("testCars", testCars),
            ("testIndex", testIndex)
        ]
    }
    
    func testCars() {
        let factory = CarFactory.make(.sports)
        let car = Car(type: .sports, floor: factory.makeFloorPlan(), suspension: factory.makeSuspension(), drive: factory.makeDriveTrain())
        XCTAssertEqual(car.type, .sports)
        XCTAssertEqual(car.floor.seats, 2)
        XCTAssertEqual(car.floor.enginePosition, .mid)
        XCTAssertEqual(car.suspension.type, .sports)
        XCTAssertEqual(car.drive.type, .rear)
        print(car.description)
    }
    
    func testIndex() {
        let str = "abc.swift"
        let e = str.endIndex
        let t = str.index(e, offsetBy: -6)
        let n = str.substring(to: t)
        XCTAssertEqual(n, "abc")
    }
    
}
