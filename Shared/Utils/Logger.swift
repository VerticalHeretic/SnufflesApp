//
//  Logger.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 29/06/2023.
//

import Foundation
import os.log

final class LoggerFactory {
    private let subsystem = Bundle.main.bundleIdentifier ?? "com.verticalcoding.SnufflesApp"
    static let shared = LoggerFactory()
    
    private init() {}
    
    func make(_ category: LogCategory) -> LogInterface {
        let logger = Logger(subsystem: subsystem,
                            category: category.name)
        return LoggerStrategy(logger: logger)
    }
}

protocol LogInterface {
    func `default`(_ message: String)
    func info(_ message: String)
    func debug(_ message: String)
    func error(_ message: String)
    func fault(_ message: String)
}

struct Log {
    private static let factory: LoggerFactory = .shared
    
    private init() {}
    
    static let `default` = factory.make(.default)
    static let userDefaults = factory.make(.userDefaults)
    static let network = factory.make(.network)
}

struct LoggerStrategy: LogInterface {
    
    private let logger: Logger
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func info(_ message: String) {
        logger.info("🌟[info] \(message)")
    }
    
    func debug(_ message: String) {
        logger.debug("🐛[debug] \(message)")
    }
    
    func error(_ message: String) {
        logger.error("❌[error] \(message)")
    }
    
    func fault(_ message: String) {
        logger.fault("⚠️[fault] \(message)")
    }
    func `default`(_ message: String) {
        logger.log("👾[default] \(message)")
    }
}

enum LogCategory {
    case `default`
    case userDefaults
    case network
    
    var name: String {
        switch self {
        case .default:              return "default"
        case .userDefaults:         return "User defaults"
        case .network:              return "Network"
        }
    }
}
