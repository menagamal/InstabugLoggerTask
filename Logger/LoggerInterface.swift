//
//  LoggerInterface.swift
//  LoggerApp
//
//  Created by Mena Gamal on 4/4/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation

protocol LoggerInterface {
    func fetch() -> [String]
    func log(message:String,level:LogLevel) -> LoggerStatus
}
