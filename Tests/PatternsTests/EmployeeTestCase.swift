//
//  EmployeeTestCase.swift
//  Patterns
//
//  Created by viwii on 2017/5/8.
//
//

import XCTest

@testable import PatternsLib

class EmployeeTestCase: XCTestCase {
    
    static var allTests: [(String, (EmployeeTestCase) -> () throws -> Void)] {
        return [
            ("testComponent1", testComponent1),
            ("testComponent2", testComponent2)
        ]
    }
    
    let search = SearchTool(sources: SalesDataSource(), DevelopmentDataSource(), NewCoDirectory())
    
    func testComponent1() {
        var res = search.search(type: .title, "Developer")
        XCTAssertEqual(res.count, 1)
        var e = res[0]
        XCTAssertEqual(e.name, "Pepe")
        
        res = search.search(type: .name, "Bob")
        XCTAssertEqual(res.count, 1)
        e = res[0]
        XCTAssertEqual(e.title, "Account Exec")
    }
    
    func testComponent2() {
        var res = search.search(type: .name, "Hans")
        XCTAssertEqual(res.count, 1)
        var e = res[0]
        XCTAssertEqual(e.title, "Corp Counsel")
        
        res = search.search(type: .title, "VP Legal")
        XCTAssertEqual(res.count, 1)
        e = res[0]
        XCTAssertEqual(e.name, "Greta")
    }
}
