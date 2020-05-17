//
//  ThemeAdopting.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

protocol ThemeAdopting {
    func setAppearance()
}

extension ThemeAdopting where Self: UIViewController {
    func setAppearance() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        guard let nav = navigationController else { return }
        let navBar = nav.navigationBar
        navBar.barStyle = .black
        navBar.barTintColor = #colorLiteral(red: 0.9443228245, green: 0.4312979877, blue: 0.05515092611, alpha: 1)
        navBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navBar.setBackgroundImage(nil, for: .default)
        navBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 19, weight: .semibold)]
        nav.interactivePopGestureRecognizer?.isEnabled = false
    }
}
