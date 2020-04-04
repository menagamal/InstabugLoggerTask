//
//  LoggerError.swift
//  LoggerApp
//
//  Created by Mena Gamal on 4/4/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation

public enum LoggerStatus : Error {
    
    case ExceedsLimts
    case FailedToFetch
    case Success
    var title : String {
        switch self {
        case .Success:
            return "Success"
        case .ExceedsLimts:
            return "Exceeding Number of Logs ."
            
        case .FailedToFetch:
            return "Error While Looding"
        }
    }
    
}



