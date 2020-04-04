//
//  Logger.swift
//  LoggerApp
//
//  Created by Mena Gamal on 4/4/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation


public class Logger :LoggerInterface{
    
    
    static let shared = Logger()
    
    private var CURRENT_SESSION_COUNTER = 0
    private var MAX_LOG_FOR_SESSION = 5000
    
    private let manager = UserDefaultsHandler()
    
    private init() {
        
        // MARK: Clear On Launch
        manager.clearAllLogs()
    }
    
    public func fetch() -> [String]{
        let logs = manager.getAllLogs()
        var sortedLogs = [String]()
        
        var logsModel = [LogModel]()
        var sortedLogsModel = [LogModel]()
        
        
        for item in logs {
            logsModel.append(decodeLog(log: item))
        }
        
        sortedLogsModel = sortLogs(logs: logsModel)
        for item in sortedLogsModel {
            
            sortedLogs.append(encodeLog(date: formatDate(date: item.date), level: item.level, message: item.message))
        }
        
        
        return sortedLogs
    }
    
    public func log(message: String, level: LogLevel) -> LoggerStatus {
        
        
        var levelType = ""
        
        // MARK: Validation
        if CURRENT_SESSION_COUNTER < MAX_LOG_FOR_SESSION {
            
            var logs = fetch()
            
            let validatedMessage = validateMessage(message: message)
            
            
            // MARK: Creation
            switch level {
            case .Error:
                levelType = "ERROR"
                break
            case .Verbose:
                levelType = "VERBOSE"
                break
            }
            
            
            let stringDate = formatDate()
            let log =   encodeLog(date: stringDate, level: levelType, message: validatedMessage)
            self.CURRENT_SESSION_COUNTER += 1
            
            //MARK: SAVING
            logs.append(log)
            manager.setLogs(value: logs)
            return .Success
            
        }
        
        return .ExceedsLimts
        
    }
    
    // MARK: FOR TESTING
    public func logCustom(date:String ,message: String, level: LogLevel){
        
        var logs = fetch()
        
        var levelType = ""

        switch level {
        case .Error:
            levelType = "ERROR"
            break
        case .Verbose:
            levelType = "VERBOSE"
            break
        }
        let log =   encodeLog(date: date, level: levelType, message: message)
        //MARK: SAVING
        logs.append(log)
        manager.setLogs(value: logs)
        
    }
}
