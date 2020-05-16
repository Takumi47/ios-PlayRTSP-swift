//
//  UIImage+.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

extension UIImage {
    private static var defaultConfig: Configuration {
        return UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
    }
    
    static var play: UIImage {
        return UIImage(systemName: "play.fill", withConfiguration: defaultConfig)!
    }
    
    static var stop: UIImage {
        return UIImage(systemName: "stop.fill", withConfiguration: defaultConfig)!
    }
}

