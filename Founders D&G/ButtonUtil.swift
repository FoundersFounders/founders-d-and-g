//
//  ButtonUtil.swift
//  Founders D&G
//
//  Created by António Ramadas on 25/09/2018.
//  Copyright © 2018 António Ramadas. All rights reserved.
//

import Foundation
import UIKit

func addShadowTo(btn: UIButton) {
    btn.layer.shadowOffset = CGSize(width: 0, height: 2)
    btn.layer.shadowOpacity = 0.3
    btn.layer.shadowRadius = 3.0
    btn.layer.masksToBounds = false
}

func animate(on: UIViewController, btn: UIButton, onComplete: @escaping () -> Void) {
    let animationLength = 0.2

    UIButton.animate(withDuration: animationLength/2,
                     animations: {btn.transform = CGAffineTransform(scaleX: 0.925, y: 0.91)},
                     completion: { _ in
                        UIButton.animate(
                            withDuration: animationLength/2,
                            animations: {btn.transform = CGAffineTransform.identity},
                            completion: { _ in onComplete()})
    })
}
