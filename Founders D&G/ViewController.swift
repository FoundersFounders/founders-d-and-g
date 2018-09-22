//
//  ViewController.swift
//  Founders D&G
//
//  Created by António Ramadas on 22/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnOpenDoor: UIButton!
    @IBOutlet weak var btnOpenGarage: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    
    // https://jgreen3d.com/animate-ios-buttons-touch/
    @IBAction func buttonTouched(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
                            
                            self.showToast(controller: self, message : "Opening...", seconds: 1.0)
        })
    }
    
    // https://stackoverflow.com/a/49454931
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func customize(btn: UIButton) {
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowRadius = 3.0
        btn.layer.cornerRadius = 3.0
        
        btn.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        
        //        btnOpenDoor.layer.masksToBounds = false
        
//        btn.frame.width = CGFloat(240)
//        btn.frame.height = CGFloat(128)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        customize(btn: btnOpenDoor)
        customize(btn: btnOpenGarage)
        customize(btn: btnSettings)
    }


}

