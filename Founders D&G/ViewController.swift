//
//  ViewController.swift
//  Founders D&G
//
//  Created by António Ramadas on 22/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnOpenFrontDoor: UIButton!
    @IBOutlet weak var btnOpenGarageDoor: UIButton!
    @IBOutlet weak var btnSiriShortcuts: UIButton!
    
    private let slack = Slack()
    
    // https://jgreen3d.com/animate-ios-buttons-touch/
    @IBAction func buttonTouched(_ sender: UIButton) {
        animate(on: self, btn: sender, onComplete: {() -> Void in
            switch sender {
            case self.btnOpenFrontDoor:
                self.handle(shortcut: .openFrontDoor)
                break
            case self.btnOpenGarageDoor:
                self.handle(shortcut: .openGarageDoor)
                break
            case self.btnSiriShortcuts:
                let url = URL(string: "https://github.com/antonio-ramadas/founders-d-and-g")!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                break
            default:
                break
            }
        })
    }
    
    @objc func longPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            let msg: String
            if (slack.isAuthenticated()) {
                UIPasteboard.general.string = SlackUtil.defaults.string(forKey: SlackUtil.defaultKey)
                msg = "Access Token copied"
            } else {
                msg = "You need to authenticate first"
            }
            showToast(message: msg)
        }
    }
    
    // https://stackoverflow.com/a/49454931
    private func showToast(message: String, seconds: Double = 1.5) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    private func customize(btn: UIButton, action: ShortcutEnum? = nil) {
        addShadowTo(btn: btn)
        
        btn.layer.cornerRadius = 3.0

        btn.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        customize(btn: btnOpenFrontDoor)
        customize(btn: btnOpenGarageDoor)
        customize(btn: btnSiriShortcuts)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        btnSiriShortcuts.addGestureRecognizer(longPress)
        
        if !self.slack.isAuthenticated() {
            self.present(SlackViewController(), animated: true)
        }
    }
    
    func handle(shortcut: ShortcutEnum) {
        if !self.slack.isAuthenticated() {
            self.present(SlackViewController(), animated: true)
        } else {
            if (slack.isCloseToTheBuilding()) {
                openDoor(shortcut: shortcut)
            } else {
                self.showToast(message : "You are too far from Founders Founders...")
            }
        }
    }
    
    func openDoor(shortcut: ShortcutEnum) {
        switch shortcut {
        case .openFrontDoor:
            self.showToast(message : "Opening front door...")
            self.slack.openFrontDoor()
            break
        case .openGarageDoor:
            self.showToast(message : "Opening garage door...")
            self.slack.openGarageDoor()
            break
        }
    }
}

