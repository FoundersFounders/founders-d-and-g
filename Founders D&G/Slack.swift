//
//  Slack.swift
//  Founders D&G
//
//  Created by António Ramadas on 30/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import Foundation

class Slack {
    
    let defaults = UserDefaults.standard
    
    func isAuthenticated() -> Bool {
        return defaults.string(forKey: "code") != nil
    }
    
    func openFrontDoor() {
        open(door: .openFrontDoor)
    }
    
    func openGarageDoor() {
        open(door: .openGarageDoor)
    }
    
    private func open(door: ShortcutEnum) {
        if let accessToken = getAccessToken() {
            switch door {
            case .openFrontDoor:
                break
            case .openGarageDoor:
                break
            }
        }
    }

    func getAccessToken() -> String? {
        return defaults.string(forKey: SlackUtil.defaultKey)
    }
}
