//
//  SLoggerTestCase.swift
//  Patterns
//
//  Created by viwii on 2017/5/4.
//
//

import XCTest

@testable import PatternsLib

class SLoggerTestCase: XCTestCase {
    
    static var allTests: [(String, (SLoggerTestCase) -> () throws -> Void)] {
        return [
            ("testSloggerSinglton", testSloggerSinglton)
        ]
    }
    
    var logs = [Slogger]()
    
    let serial = DispatchQueue(label: "com.slogger.test")
    
    func append(_ log: Slogger) {
        serial.sync {
            logs.append(log)
        }
    }
    
    func testSloggerSinglton() {
        
        let queue = DispatchQueue(label: "com.testlog", attributes: .concurrent)
        let group = DispatchGroup()
        
        queue.async(group: group) {
            self.append( Slogger.default )
            Slogger.default.append(item: LogItem(type: LogItem.ItemType.proposal, data: "1"))
        }
        queue.async(group: group) {
            self.append(Slogger.default)
            Slogger.default.append(item: LogItem(type: LogItem.ItemType.proposal, data: "2"))
        }
        queue.async(group: group) {
            self.append(Slogger.default)
            Slogger.default.append(item: LogItem(type: LogItem.ItemType.proposal, data: "3"))
        }
        queue.async(group: group) {
            self.append(Slogger.default)
            Slogger.default.append(item: LogItem(type: LogItem.ItemType.proposal, data: "4"))
        }
        queue.async(group: group) {
            self.append(Slogger.default)
            Slogger.default.append(item: LogItem(type: LogItem.ItemType.proposal, data: "5"))
        }
        queue.async(group: group) {
            self.append(Slogger.default)
            Slogger.default.append(item: LogItem(type: LogItem.ItemType.proposal, data: "6"))
        }
        group.notify(queue: queue) {
            
            XCTAssertEqual(self.logs.count, 6)
            XCTAssertEqual(Slogger.default.count, 6)
            
            let a = self.logs.first!
            
            self.logs.forEach({ (l) in
                XCTAssertTrue(a === l)
            })
            
            print("Done")
        }
        
        let res = group.wait(timeout: .distantFuture)
        
        XCTAssert(res == .success)
        
        print("Exit")
    }
}
