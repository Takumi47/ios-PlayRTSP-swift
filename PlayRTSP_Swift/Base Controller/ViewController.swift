//
//  ViewController.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

private let kDefaultNavigationBarTitle = "RTSP List"

class ViewController: UIViewController, ThemeAdopting {
    
    var currentTitle: String? { kDefaultNavigationBarTitle }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title = currentTitle
        setAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppearance()
    }
}
