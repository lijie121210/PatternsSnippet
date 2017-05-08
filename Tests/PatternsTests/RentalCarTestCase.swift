//
//  RentalCarTestCase.swift
//  Patterns
//
//  Created by viwii on 2017/5/5.
//
//

import XCTest

@testable import PatternsLib

class RentalCarTestCase: XCTestCase {
    
    static var allTests: [(String, (RentalCarTestCase) -> () throws -> Void)] {
        return [
            ("testFactory", testFactory)
        ]
    }
    
    func testFactory() {
        let sc = RentalCar.make(passengers: 1)
        XCTAssertNotNil(sc)
        XCTAssertTrue(sc! is SmallCompact, "small compact error")
        
        let c = RentalCar.make(passengers: 3)
        XCTAssertNotNil(c)
        XCTAssertTrue(c is Compact, "compact error")
        
        let suv = RentalCar.make(passengers: 6)
        XCTAssertNotNil(suv)
        XCTAssertTrue(suv is SUV, "suv error")
        
        let nn = RentalCar.make(passengers: -1)
        let mm = RentalCar.make(passengers: 9)
        XCTAssertNil(nn)
        XCTAssertNil(mm)
    }
}
