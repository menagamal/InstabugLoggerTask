//
//  LoggerAppTests.swift
//  LoggerAppTests
//
//  Created by khaled mohamed el morabea on 2/23/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import XCTest
@testable import LoggerApp

class LoggerAppTests: XCTestCase {
    
    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetch() {
        
        let _ = Logger.shared.log(message: "Mina", level: .Verbose)
        let _ = Logger.shared.log(message: "Mina", level: .Verbose)
        let _ = Logger.shared.log(message: "Mina", level: .Verbose)
        
        let logs = Logger.shared.fetch()
        XCTAssertNotNil(logs)
        if logs.isEmpty {
            XCTFail()
        }
        
    }
    func testLog() {
        let result = Logger.shared.log(message: "Mina", level: .Verbose)
        if result != .Success {
            XCTFail()
        }
        
    }
    
    func testLoadBalancer() {
        for i in 0...5000 {
            let result = Logger.shared.log(message: "MIna", level: .Error)
            if i > 99 {
                if result != .ExceedsLimts {
                    XCTFail()
                }
            }
            
        }
        
    }
    func testValidateMessage()  {
        let message = "MinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMinaMina"
        let validatedMessage = Logger.shared.validateMessage(message: message)
        
        if validatedMessage.count != 1003 {
            XCTFail()
        }
        
        let last3 = String(validatedMessage.suffix(3))
        if !last3.elementsEqual("...") {
            XCTFail()
        }
        
    }
    
    
    func testEncodeLog()  {
        
        let log = Logger.shared.encodeLog(date: "Apr 01,1999", level: "ERROR", message: "Mina")
        if !log.elementsEqual("[Apr 01,1999-ERROR-Mina]") {
            XCTFail()
        }
    }
    
    func testDecodeLog()  {
        let values = Logger.shared.decodeLog(log: "[Apr 01,1999-ERROR-Mina]")
        if values.date == nil {
            XCTFail()
        }
        if values.level == nil , !values.level.isEmpty {
            XCTFail()
        }
        if values.message == nil , !values.message.isEmpty {
            XCTFail()
        }
        
    }
    func testFetchSorted() {
        
        Logger.shared.logCustom(date: "Apr 01,1919", message: "7", level: .Verbose)
        Logger.shared.logCustom(date: "Apr 01,1959", message: "6", level: .Verbose)
        Logger.shared.logCustom(date: "Apr 01,1996", message: "5", level: .Verbose)
        Logger.shared.logCustom(date: "Apr 01,1997", message: "4", level: .Verbose)
        Logger.shared.logCustom(date: "Apr 01,2020", message: "1", level: .Verbose)
        Logger.shared.logCustom(date: "Apr 01,2015", message: "2", level: .Verbose)
        Logger.shared.logCustom(date: "Apr 01,2005", message: "3", level: .Verbose)
        
        
        
        let logs = Logger.shared.fetch()
        var logsModel = [LogModel]()
        var sortedLogsModel = [LogModel]()
        
        for item in logs {
            let value = Logger.shared.decodeLog(log: item)
            logsModel.append(value)
        }
        
        sortedLogsModel = Logger.shared.sortLogs(logs: logsModel)
        for i in 0..<sortedLogsModel.count - 1 {
            if sortedLogsModel[i].date < sortedLogsModel[i+1].date {
                XCTFail()
            }
        }
        
    }
    
    
    func testFormatDate()  {
        let dateString = "Apr 01,1999"
        let currentDate = Date()
        let d = Logger.shared.getDateFromString(str: dateString)
        if currentDate == d {
            XCTFail()
        }
    }
    
    func testStringFromDate()  {
        // TODAY
        let currentDate = Logger.shared.formatDate()
        
        let str = "Apr 01,1999"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let date = dateFormatter.date(from:str)
        
        let tempDate = Logger.shared.formatDate(date: date)
        if currentDate.elementsEqual(tempDate) {
            XCTFail()
        }
    }
    
}
