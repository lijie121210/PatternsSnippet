//
//  DeepCopyMe.swift
//  Patterns
//
//  Created by viwii on 2017/5/3.
//
//

import Foundation

public enum DCSubject: String, Hashable {
    case english = "english"
    case chinese = "chinese"
    
    public var hashValue: Int {
        return self.rawValue.hashValue
    }
}

open class DCMember: NSCopying, Equatable, Hashable {
    
    public var id: String
    
    init(id: String) {
        self.id = id
    }
    
    public var hashValue: Int {
        return id.hashValue
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return DCMember(id: id)
    }
}

public final class DCStudent: DCMember {

    public var age: Int
    
    public init(id: String, age: Int) {
        self.age = age
        super.init(id: id)
    }
    
    public override var hashValue: Int {
        return id.hashValue ^ age.hashValue
    }
    
    /// NSCopying
    public override func copy(with zone: NSZone? = nil) -> Any {
        return DCStudent(id: id, age: age)
    }
}

public final class DCTeacher: DCMember {
    
    public var subject: DCSubject
    
    init(id: String, subject: DCSubject) {
        self.subject = subject
        super.init(id: id)
    }
    
    public override var hashValue: Int {
        return  id.hashValue ^ subject.hashValue
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        return DCTeacher(id: id, subject: subject)
    }
}

public final class DCProcessor {
    
    var members: [DCMember]
    
    init() {
        members = []
    }
    
    public var count: Int {
        return members.count
    }
    
    public subscript (index: Int) -> DCMember {
        return members[index]
    }
    
    public func append(member: DCMember) {
        if let member = member.copy() as? DCMember {
            members.append(member)
        } else {
            assertionFailure(#function)
        }
    }
    
    public func call(process: (DCMember) -> Void) {
        members.forEach(process)
    }
}

/// Equatable

public func ==(lhs: DCMember, rhs: DCMember) -> Bool {
    return lhs.id == rhs.id
}

public func ==(lhs: DCStudent, rhs: DCStudent) -> Bool {
    return lhs.id == rhs.id && lhs.age == rhs.age
}

public func ==(lhs: DCTeacher, rhs: DCTeacher) -> Bool {
    return lhs.id == rhs.id && lhs.subject == rhs.subject
}
