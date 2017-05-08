//
//  SLogger.swift
//  Patterns
//
//  Created by viwii on 2017/5/4.
//
//

import Foundation

public struct LogItem {
    
    public enum ItemType {
        case error, proposal, other
    }
    
    public let type: ItemType
    public let data: String
    
    public var description: String {
        return "[\(type)]-[\(data)]"
    }
}

// 1.

final public class Slogger {
    private init() {}
    private let queue = DispatchQueue(label: "com.slogger")
    private var items: [LogItem] = []

    public static let `default`: Slogger = Slogger()

    public var count: Int {
        return items.count
    }
    
    public subscript (index: Int) -> LogItem {
        return items[index]
    }
    
    public func append(item: LogItem) {
        queue.sync {
            items.append(item)
        }
    }
    
    public func call(process: (LogItem) -> Void) {
        queue.sync {
            items.forEach(process)
        }
    }
}

// 2.

public let sharedSGlogger: SGlogger = SGlogger()

final public class SGlogger {
    fileprivate init() {}
    private let queue = DispatchQueue(label: "com.slogger")
    private var items: [LogItem] = []
    
    public func append(item: LogItem) {
        queue.sync {
            items.append(item)
        }
    }
    
    public func call(process: (LogItem) -> Void) {
        queue.sync {
            items.forEach(process)
        }
    }
}

// 3.

final public class SSlogger {
    private init() {}
    private let queue = DispatchQueue(label: "com.slogger")
    private var items: [LogItem] = []
    
    class var `default`: SSlogger {
        struct SingltonLogger {
            static let logger: SSlogger = SSlogger()
        }
        return SingltonLogger.logger
    }
    
    
    public func append(item: LogItem) {
        queue.sync {
            items.append(item)
        }
    }
    
    public func call(process: (LogItem) -> Void) {
        queue.sync {
            items.forEach(process)
        }
    }
}


