//
//  SlackViewController.swift
//  Founders D&G
//
//  Created by António Ramadas on 30/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import Foundation
import WebKit

class SlackViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        let myURL = URL(string:"https://slack-proxy-oauth2.herokuapp.com/oauth/authorize")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            if let host = url.host {
                if (host == "localhost") {//founders-founders.com") {
                    if let code = self.extractCodeFrom(query: url.query) {
                        saveAccessToken(code: code)
                    }
                    dismiss(animated: true, completion: nil)
                }
            }
        }

        decisionHandler(.allow)
    }
    
    func extractCodeFrom(query optQuery: String?) -> String? {
        if let query = optQuery {
            let params = query.split(separator: "&")
            
            for param in params {
                let kvParam = param.split(separator: "=")
                
                if kvParam[0] == "code" {
                    return String(kvParam[1])
                }
            }
        }
        
        return nil
    }
    
    func saveAccessToken(code: String) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://slack-proxy-oauth2.herokuapp.com/api/oauth.access?code=\(code)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error == nil) {
                do {
                    if let responseData = data {
                        guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: [])
                        as? [String: Any] else {
                            print("Error trying to convert data to JSON")
                            return
                        }
                    
                        guard let access_token = jsonData["access_token"] as? String else {
                            print("Error trying to get access_token from data")
                            return
                        }
                        
                        SlackUtil.defaults.set(access_token, forKey: SlackUtil.defaultKey)
                    }
                } catch {
                    print("Error trying to convert data to JSON")
                }
            }
        })
        
        dataTask.resume()
    }
}
