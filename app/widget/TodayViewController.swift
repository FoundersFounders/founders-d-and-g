//
//  TodayViewController.swift
//  widget
//
//  Created by António Ramadas on 23/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var btnOpenFrontDoor: UIButton!
    @IBOutlet weak var btnOpenGarageDoor: UIButton!
    @IBOutlet weak var lblAuthentication: UILabel!
    
    private let slack = Slack()
    
    // https://jgreen3d.com/animate-ios-buttons-touch/
    @IBAction func buttonTouched(_ sender: UIButton) {
        if (!self.slack.isCloseToTheBuilding()) {
            return
        }
        animate(on: self, btn: sender, onComplete: {() in
            switch sender {
            case self.btnOpenFrontDoor:
                self.slack.openFrontDoor()
                break
            case self.btnOpenGarageDoor:
                self.slack.openGarageDoor()
                break
            default:
                print("Unrecognized button touched")
                break
            }
        })
    }
    
    func customize(btn: UIButton) {        
        // Make it like a circle
        btn.layer.cornerRadius = btn.frame.size.width / 2
        
        addShadowTo(btn: btn)
        
        // Increase size of button's image
        btn.imageEdgeInsets = UIEdgeInsets(top: 65, left: 65, bottom: 65, right: 65)
        
        btn.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        customize(btn: btnOpenFrontDoor)
        customize(btn: btnOpenGarageDoor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isAuthenticated = slack.isAuthenticated()
        
        lblAuthentication.isHidden = isAuthenticated
        btnOpenFrontDoor.isHidden = !isAuthenticated
        btnOpenGarageDoor.isHidden = !isAuthenticated
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
