//
//  SettingManager.swift
//  SmartShop
//
//  Created by 1 on 9/16/19.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

class SettingManager: NSObject {
    
    static let shared: SettingManager = { SettingManager() }()
    lazy var apiURL: String = {
        return "https://jsonstorage.net/api/items/385e07fb-3e90-4803-bc10-6a57a8a6dfa1"
    }()
    
    
    
}
