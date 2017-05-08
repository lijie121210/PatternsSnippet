//
//  Pool.swift
//  Patterns
//
//  Created by viwii on 2017/5/5.
//
//

import Foundation

public enum OPoolError: Error {
    case empty
}

open class OPool<T> {

    private var items: [T]

    private let queue = DispatchQueue(label: "com.slogger")
    private let semaphore: DispatchSemaphore
    public var objc: T? {
        get {
            var res: T?
            // if signal count < 0, block the thread until signal count > 0
            if case .success = semaphore.wait(wallTimeout: .now() + 3600) {
                queue.sync { res = items.remove(at: 0) }
            }
            return res
        }
        set {
            queue.async {
                if let t = newValue {
                    self.items.append(t)
                    self.semaphore.signal()
                }
            }
        }
    }
    
    public var count: Int {
        return items.count
    }
    
    public init(_ objcs: [T]) {
        items = [T]()
        semaphore = DispatchSemaphore(value: objcs.count)
        
        objcs.forEach { items.append($0) }
    }
    
    public func sync(process: (T) -> Void) {
        queue.sync(flags: .barrier) {
            self.items.forEach(process)
        }
    }
}

open class OPBook: CustomStringConvertible {
    let id: String
    var reader: String?
    var checkoutCount: Int
    
    fileprivate init(id: String) {
        self.id = id
        self.checkoutCount = 0
        self.reader = nil
    }
    
    public var description: String {
        return "Book<\(id)>, checked out \(checkoutCount) times, " + (reader == nil ? "in stock." : "checking out to \(reader!).")
    }
}

final class Library {
    
    static let `default`: Library = Library(count: 10)
    
    private let pool: OPool<OPBook>

    private init(count: Int) {
        var books = [OPBook]()
        for i in 0..<count {
            let book = OPBook(id: "#TP321.\(i)")
            books.append(book)
        }
        pool = OPool(books)
    }
    
    class func checkoutBook(reader: String) throws -> OPBook {
        guard let book = Library.default.pool.objc else {
            throw OPoolError.empty
        }
        book.reader = reader
        book.checkoutCount += 1
        return book
    }
    
    class func returnBook(book: OPBook) {
        book.reader = nil
        Library.default.pool.objc = book
    }
    
    class func report() {
        Library.default.pool.sync { (b) in
            print(b.description)
        }
    }
    
    class var checkoutSum: Int {
        var sum = 0
        Library.default.pool.sync {
            sum += $0.checkoutCount
        }
        return sum
    }
}
