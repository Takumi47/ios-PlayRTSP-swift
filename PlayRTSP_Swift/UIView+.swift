//
//  UIView+.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

private let kShakeAnimationKey = "shaking"

extension UIView {
    func edges(to view: UIView, top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom),
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right)
        ])
    }
    
    func startShaking() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        
        let startAngle = 2 * Float.pi / 180
        let stopAngle = -startAngle
        shakeAnimation.fromValue = NSNumber(value: 2 * startAngle)
        shakeAnimation.toValue = NSNumber(value: 2 * stopAngle)
        shakeAnimation.duration = 0.12
        shakeAnimation.repeatCount = 10000
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        layer.add(shakeAnimation, forKey: kShakeAnimationKey)
    }
    
    func stopShaking() {
        layer.removeAnimation(forKey: kShakeAnimationKey)
    }
}

