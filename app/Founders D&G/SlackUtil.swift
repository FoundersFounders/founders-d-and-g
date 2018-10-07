//
//  SlackUtil.swift
//  Founders D&G
//
//  Created by António Ramadas on 30/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import Foundation

struct SlackUtil {
    static let channel = "general"
    
    static let defaults = UserDefaults.init(suiteName: ProcessInfo.processInfo.environment["suiteName"])!
    static let defaultKey = "accessToken"
}
