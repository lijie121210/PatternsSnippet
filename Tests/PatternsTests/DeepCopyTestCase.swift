//
//  DeepCopysTestCase.swift
//  Patterns
//
//  Created by viwii on 2017/5/3.
//
//

import XCTest

@testable import PatternsLib

class DeepCopyTestCase: XCTestCase {
    
    static var allTests: [(String, (DeepCopyTestCase) -> () throws -> Void)] {
        return [
            ("testSubjectEqual", testSubjectEqual),
            ("testTeacherEqual", testTeacherEqual),
            ("testTeacherCopy", testTeacherCopy),
            ("testTeacherHashEqual_id", testTeacherHashEqual_id),
            ("testProcessorTeacherEqual", testProcessorTeacherEqual)
        ]
    }
    
    func testSubjectEqual() {
        let a = DCSubject.chinese
        let b = DCSubject.english
        XCTAssertNotEqual(a.hashValue, b.hashValue)
    }
    
    func testTeacherEqual() {
        let a = DCTeacher(id: "#T1", subject: .chinese)
        let b = DCTeacher(id: "#T2", subject: .english)
        let c = DCTeacher(id: "#T1", subject: .chinese)

        XCTAssertFalse(a == b)
        XCTAssertFalse(a === b)
        XCTAssertTrue(a == c)
        XCTAssertFalse(a === c)
    }
    
    func testTeacherCopy() {
        let a = DCTeacher(id: "#T1", subject: .chinese)
        let b = a.copy() as! DCTeacher
        
        XCTAssertFalse(a === b)

        XCTAssertTrue(a == b)
        
        b.subject = .english

        XCTAssertFalse(a == b)
    }
    
    func testTeacherHashEqual_id() {
        let a = DCTeacher(id: "#T1", subject: .chinese)
        
        var msets:Set<DCMember> = []
        msets.insert(a)
        
        var d = a.copy() as! DCTeacher
        d.id = "#T00212"
        
        let res = msets.insert(d)
        XCTAssertTrue(res.inserted, "insert failed")
    }
    
    func testTeacherHashEqual_subject() {
        let a = DCTeacher(id: "#T1", subject: .chinese)
        
        var msets:Set<DCMember> = []
        msets.insert(a)
        
        var d = a.copy() as! DCTeacher
        d.subject = .english
        
        let res = msets.insert(d)
        XCTAssertTrue(res.inserted, "insert failed")
    }
    
    func testProcessorTeacherEqual() {
        let p = DCProcessor()
        
        var a = DCTeacher(id: "#T1", subject: .chinese)
        p.append(member: a)
        a.id = "#T0212"
        p.append(member: a)
        XCTAssertEqual(p.count, 2, "error 1")
        
        var msets:Set<DCMember> = []
        p.call { (m) in
            let res = msets.insert(m)
            XCTAssertTrue(res.inserted, "insert error 1")
        }
        msets.removeAll()
        
        a.id = "#T1"
        a.subject = .english
        p.append(member: a)
        XCTAssertEqual(p.count, 3, "error 2")
        
        p.call { (m) in
            let res = msets.insert(m)
            XCTAssertTrue(res.inserted, "insert error 2")
        }
        msets.removeAll()
    }
}
