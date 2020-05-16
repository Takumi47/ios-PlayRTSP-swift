//
//  RTSPViewController.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit
import Hero

class RTSPViewController: UIViewController {

    // MARK: - Properties
    
    var uuid: String?
    
    private let panGesture = UIPanGestureRecognizer()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panGesture.delegate = self
        panGesture.addTarget(self, action: #selector(pan))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let uuid = uuid,
//            let media = IJKMediaService.shared.fetch(with: uuid),
//            let playerView = media.player?.view {
//            media.player?.scalingMode = .aspectFit
//            playerView.frame = view.bounds
//            view.autoresizesSubviews = true
//            view.addSubview(playerView)
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let orientation = UIDevice.current.orientation
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            view.contentMode = .scaleToFill
        } else {
            view.contentMode = .scaleAspectFit
        }
    }
    
    // MARK: - Selector
    
    @objc func canRotate() {}
    
    @objc func pan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            hero.dismissViewController()
        default:
            Hero.shared.finish()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension RTSPViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let velocity = panGesture.velocity(in: nil)
        return velocity.y > abs(velocity.x)
    }
}
