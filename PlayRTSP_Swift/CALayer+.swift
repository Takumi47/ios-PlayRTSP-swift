//
//  CALayer+.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

private let kContentLayerName = "ContentLayerName"

extension CALayer {
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    
    func addShadow(_ offset: CGSize = .zero, _ opacity: Float = 0.2, _ radius: CGFloat = 12, _ color: UIColor? = .systemGray) {
        self.shadowOffset = offset
        self.shadowOpacity = opacity
        self.shadowRadius = radius
        self.shadowColor = color?.cgColor
        self.masksToBounds = false
        
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    
    // MARK: - Private Implementation
    
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter { $0.frame.equalTo(self.bounds) }.forEach {
                $0.roundCorners(radius: self.cornerRadius)
            }
            
            self.contents = nil
            
            if let sublayer = sublayers?.first, sublayer.name == kContentLayerName {
                sublayer.removeFromSuperlayer()
            }
            
            let contentLayer = CALayer()
            contentLayer.name = kContentLayerName
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            
            insertSublayer(contentLayer, at: 0)
        }
    }
}

