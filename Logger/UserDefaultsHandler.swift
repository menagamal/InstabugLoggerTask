//
//  UserDefaultsHandler.swift
//  LoggerApp
//
//  Created by Mena Gamal on 4/4/20.
//  Copyright © 2020 Instabug. All rights reserved.
//


import Foundation

class UserDefaultsHandler {
    
    enum Settings : String {
        case  Logs
    }
    
    
    var userDefault: UserDefaults
    
    init() {
        userDefault = UserDefaults.standard
    }
    
    
    
    func getAllLogs() -> [String] {
        if let object = userDefault.object(forKey: Settings.Logs.rawValue) {
            return object as! [String]
        }
        return [String]()
    }
    func setLogs(value:[String]) {
        let _ =  save(object: value, setting: Settings.Logs)
    }
    
    func clearAllLogs()  {
        userDefault.removeObject(forKey: Settings.Logs.rawValue)
    }
    
    
    private func save(object: Any, setting: Settings) -> Bool {
        if (object is Int) {
            userDefault.set(object as! Int, forKey: setting.rawValue)
        } else if (object is Bool) {
            userDefault.set(object as! Bool, forKey: setting.rawValue)
        } else if (object is String) {
            userDefault.set(object as! String, forKey: setting.rawValue)
        } else {
            userDefault.set(object, forKey: setting.rawValue)
        }
        
        return userDefault.synchronize()
    }
    
}
