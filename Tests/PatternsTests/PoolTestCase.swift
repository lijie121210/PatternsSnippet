//
//  PoolTestCase.swift
//  Patterns
//
//  Created by viwii on 2017/5/5.
//
//

import XCTest

@testable import PatternsLib

class PoolTestCase: XCTestCase {
    
    static var allTests: [(String, (PoolTestCase) -> () throws -> Void)] {
        return [
            ("testLibrary", testLibrary)
        ]
    }
    
    let queue = DispatchQueue(label: "com.pool.test", attributes: .concurrent)
    let group = DispatchGroup()
    
    func testLibrary() {
        for i in 0..<100 {
            queue.async(group: group, execute: {
                let reader = String(format: "#R%04d", i)
                do {
                    let book = try Library.checkoutBook(reader: reader)
                    
                    Thread.sleep(forTimeInterval: TimeInterval(arc4random() % 2))
                    
                    Library.returnBook(book: book)
                } catch {
                    print("check failed \(i)")
                }
            })
        }
        
        // syncronize. block the thread
        group.wait()
        print("Exit")
        Library.report()
        
        XCTAssertEqual(Library.checkoutSum, 100)
    }
}
