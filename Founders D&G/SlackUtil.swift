//
//  SlackUtil.swift
//  Founders D&G
//
//  Created by António Ramadas on 30/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import Foundation

struct SlackUtil {
    static let clientID = ProcessInfo.processInfo.environment["clientID"]
    static let clientSecret = ProcessInfo.processInfo.environment["clientSecret"]
    static let scope = ProcessInfo.processInfo.environment["scope"]
    static let team = ProcessInfo.processInfo.environment["team"]
    
    static let defaults = UserDefaults.init(suiteName: ProcessInfo.processInfo.environment["suiteName"])!
    static let defaultKey = "accessToken"
}
