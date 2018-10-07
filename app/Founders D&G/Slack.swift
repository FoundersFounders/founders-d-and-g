//
//  Slack.swift
//  Founders D&G
//
//  Created by António Ramadas on 30/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import Foundation
import CoreLocation

class Slack {

    private let manager = CLLocationManager()
    
    init() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func isCloseToTheBuilding() -> Bool {
        if let location = manager.location {
            let myCoordinates = location.coordinate
            let myLocation = CLLocation(latitude: myCoordinates.latitude, longitude: myCoordinates.longitude)
            let foundersFoundersLocation = CLLocation(latitude: 41.161860, longitude: -8.602319)
            
            let distanceToFoundersFounders = myLocation.distance(from: foundersFoundersLocation)
            
            return distanceToFoundersFounders <= 100 // in meters
        }
        
        return true
    }
    
    func isAuthenticated() -> Bool {
        return getAccessToken() != nil
    }
    
    func openFrontDoor() {
        open(door: .openFrontDoor)
    }
    
    func openGarageDoor() {
        open(door: .openGarageDoor)
    }
    
    private func open(door: ShortcutEnum) {
        switch door {
        case .openFrontDoor:
            send(message: "@door-service: open - via iOS app <https://github.com/antonio-ramadas/founders-d-and-g|get yours here>")
            break
        case .openGarageDoor:
            send(message: "@door-service: garage - via iOS app <https://github.com/antonio-ramadas/founders-d-and-g|get yours here>")
            break
        }
    }

    func getAccessToken() -> String? {
        return SlackUtil.defaults.string(forKey: SlackUtil.defaultKey)
    }
    
    func send(message: String) {
        guard let accessToken = getAccessToken() else {
            return
        }
        
        let headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let postData = NSData(data: """
                    {
                    "channel": "\(SlackUtil.channel)",
                    "text": "\(message)",
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
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//            }
        })
        
        dataTask.resume()
    }
}
