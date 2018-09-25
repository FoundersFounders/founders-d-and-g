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
    
    // https://jgreen3d.com/animate-ios-buttons-touch/
    @IBAction func buttonTouched(_ sender: UIButton) {
        animate(on: self, btn: sender, onComplete: {() in })
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
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
