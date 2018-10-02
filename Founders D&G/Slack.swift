//
//  Slack.swift
//  Founders D&G
//
//  Created by António Ramadas on 30/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import Foundation
import Alamofire

class Slack {
    
    private let defaults = UserDefaults.standard
    
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
        let msg = "Message sent from iOS simulator as a GET"
        let url = URL(string: "https://slack.com/api/chat.postMessage")!
        
        if let accessToken = getAccessToken() {
            switch door {
            case .openFrontDoor:
                
                let parameters: Parameters = [
                    "token": accessToken,
                    "channel": "general",
                    "text": msg,
                    "link_names": 1,
                    "as_user": true
                ]
                
                Alamofire.request(url, method: .get, parameters: parameters)//, encoding: URLEncoding(destination: .queryString), headers: nil)
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
