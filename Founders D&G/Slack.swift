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
        return defaults.string(forKey: SlackUtil.defaultKey) != nil
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
                
                let headers = [
                    "Content-Type": "application/json; charset=utf-8",
                    "Authorization": "Bearer \(accessToken)"
                ]
                
                let postData = NSData(data: """
                    {
                    "channel": "general",
                    "text": "Message sent from iOS as a POST",
                    "link_names": 1,
                    "as_user": true
                    }
                    """.data(using: String.Encoding.utf8)!)
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://slack.com/api/chat.postMessage")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                }
            })
            
            dataTask.resume()
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
