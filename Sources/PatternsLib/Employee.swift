//
//  Employee.swift
//  Patterns
//
//  Created by viwii on 2017/5/7.
//
//

import Foundation



// Components 1

public struct Employee {
    public var name: String
    public var title: String
}

public protocol EmployeeDataSource {
    var employees: [Employee] { get }
    
    func search(byName name: String) -> [Employee]
    
    func search(byTitle title: String) -> [Employee]
}

public extension EmployeeDataSource {
    func search(filter: (Employee) -> Bool) -> [Employee] {
        return employees.filter(filter)
    }
    
    func search(byName name: String) -> [Employee] {
        return search(filter: { (e) -> Bool in
            return e.name.range(of: name) != nil
        })
    }
    
    func search(byTitle title: String) -> [Employee] {
        return search(filter: { (e) -> Bool in
            return e.title.range(of: title) != nil
        })
    }
}

public class SalesDataSource: EmployeeDataSource {
    
    public var employees: [Employee]
    
    public init() {
        employees = [
            Employee(name: "Alice", title: "VP of Sales"),
            Employee(name: "Bob", title: "Account Exec")
        ]
    }
}

public class DevelopmentDataSource: EmployeeDataSource {
    
    public var employees: [Employee]
    
    public init() {
        employees = [
            Employee(name: "Joe", title: "VP of Development"),
            Employee(name: "Pepe", title: "Developer")
        ]
    }
}




// Components 2

public class NewCoStaffMember {
    private(set) var name: String
    private(set) var role: String
    init(name: String, role: String) {
        self.name = name
        self.role = role
    }
}

public class NewCoDirectory {
    private(set) var staff: [String:NewCoStaffMember]
    init() {
        staff = [
            "Hans": NewCoStaffMember(name: "Hans", role: "Corp Counsel"),
            "Greta": NewCoStaffMember(name: "Greta", role: "VP Legal")
        ]
    }
}





// Adaptor with `extension`

extension NewCoDirectory: EmployeeDataSource {
    
    func createEmployees(_ filter: (NewCoStaffMember) -> Bool) -> [Employee] {
        return staff.filter { (_, value) -> Bool in
            return filter(value)
        }.map { (_, value) -> Employee in
            return Employee(name: value.name, title: value.role)
        }
    }
    
    public var employees: [Employee] {
        return staff.map { (key: String, value: NewCoStaffMember) -> Employee in
            Employee(name: value.name, title: value.role)
        }
    }
    
    public func search(byName name: String) -> [Employee] {
        return createEmployees { (m) -> Bool in
            return m.name.range(of: name) != nil
        }
    }
    
    public func search(byTitle title: String) -> [Employee] {
        return createEmployees { (m) -> Bool in
            return m.role.range(of: title) != nil
        }
    }
}





// Tool

public class SearchTool {
    public enum SearchType {
        case name, title
    }
    
    let sources: [EmployeeDataSource]
    
    public init(sources: EmployeeDataSource...) {
        self.sources = sources
    }
    
    public var employees: [Employee] {
        var res = [Employee]()
        sources.forEach { res += $0.employees }
        return res
    }
    
    public func search(type: SearchType, _ text: String) -> [Employee] {
        var res = [Employee]()
        switch type {
        case .name: sources.forEach { res += $0.search(byName: text) }
        case .title: sources.forEach { res += $0.search(byTitle: text) }
        }
        return res
    }
}
