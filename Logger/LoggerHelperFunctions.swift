//
//  LoggerHelperFunctions.swift
//  LoggerApp
//
//  Created by Mena Gamal on 4/4/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation


extension Logger{
    // MARK: HelperFunctions
    func validateMessage(message:String) -> String {
        var newMessage = ""
        if message.count > 1000 {
            newMessage = message.prefix(1000) + "..."
        } else {
            newMessage = message
        }
        return newMessage
    }
    
    func formatDate(date:Date! = nil) -> String {
        if date == nil {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy"
            return dateFormatter.string(from: currentDate)
        } else {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy"
            return dateFormatter.string(from: date!)
        }
        
        
    }
    
    func getDateFromString(str:String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        if let date = dateFormatter.date(from:str) {
            return date
        }
        return Date()
    }
    
    
    func encodeLog(date:String,level:String,message:String) ->  String {
        return "[\(date)-\(level)-\(message)]"
    }
    
    
    func decodeLog(log:String) -> LogModel {
        var currentLog = log
        currentLog.removeLast()
        currentLog.removeFirst()
        let logsContent = currentLog.split{$0 == "-"}.map(String.init)
        let logsDate = getDateFromString(str: logsContent[0])
        
        let logModel = LogModel(date: logsDate, level: logsContent[1], message: logsContent[2])
        
        return logModel
    }
    
    func sortLogs(logs:[LogModel]) -> [LogModel]  {
        return   logs.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
    }
   
    
}
