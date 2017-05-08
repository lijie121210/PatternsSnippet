//
//  Utils.swift
//  Patterns
//
//  Created by viwii on 2017/5/3.
//
//

import Foundation


public enum PatternType {
    case objectTemplate
    case prototype
    case singleton
    case objectPool
    case factoryMethod
    case abstractFactory
    case builder
    case adapter
}


public struct Utils {
    
    static var usage: String {
        return
            "\nUsage:" +
            "\nPatterns [aPatternName]\n" +
            "Pattern names: \n" +
            "objectTemplate;\n" +
            "prototype;\n" +
            "singleton;\n" +
            "objectPool;\n" +
            "factoryMethod;\n" +
            "abstractFactory;\n" +
            "builder;\n" +
            "adapter;\n"

    }
    
    public static func exitSuccess() {
        Darwin.exit(EXIT_SUCCESS)
    }
    
    public static func exitFailure() {
        Darwin.exit(EXIT_FAILURE)
    }
    
    public static func printUsage() {
        
        print(usage)
        // FileHandle.standardError.write(usage.data(using: .utf8)!)
    }
    
    public static func exit(with message: String? = nil) {
        print(message ?? usage)
        Darwin.exit(EXIT_SUCCESS)
    }
}
