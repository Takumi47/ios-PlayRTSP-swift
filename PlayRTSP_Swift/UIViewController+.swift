//
//  UIViewController+.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

extension UIViewController {
    var contentViewController: UIViewController? {
        if let contentVC = (self as? UITabBarController)?.selectedViewController {
            return contentVC.contentViewController
        } else if let contentVC = (self as? UINavigationController)?.visibleViewController {
            return contentVC.contentViewController
        } else if let contentVC = self.presentedViewController {
            return contentVC.contentViewController
        }
        return self
    }
}

extension UIApplication {
    var mainWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
            return windowScene.windows.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    var contentViewController: UIViewController? {
        return mainWindow?.rootViewController?.contentViewController
    }
}
