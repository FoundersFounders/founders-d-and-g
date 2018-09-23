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
                            
                            let btnTitle = sender.titleLabel?.text ?? "[Button Title missing]"
                            
                            self.showToast(message : "Opening from \"\(btnTitle)\"")
        })
    }
    
    // https://stackoverflow.com/a/49454931
    func showToast(message : String, seconds: Double = 1.5) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        customize(btn: btnOpenFrontDoor)
        customize(btn: btnOpenGarageDoor)
        customize(btn: btnSettings)
    }
    
    func handle(shortcut: ShortcutEnum) {
        let action = shortcut.rawValue
        showToast(message: "Opening from \(action)")
    }
}

