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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        let myURL = URL(string:"https://slack.com/oauth/authorize?client_id=\(SlackUtil.clientID)&client_secret=\(SlackUtil.clientSecret)&scope=\(SlackUtil.scope)&team=\(SlackUtil.team)")
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
        // TODO get access token
        defaults.set(code, forKey: SlackUtil.defaultKey)
    }
}
