//
//  XButton.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

class XButton: UIButton {
    
    // MARK: - Properties
    
    private let message = "Tap to add RTSP!"
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
    
    // MARK: - Methods
    
    func isVisible(_ isOn: Bool) {
        isOn ? show() : hide()
    }
    
    func show() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) { [weak self] in
            UIView.animate(
                withDuration: 1,
                delay: 0,
                options: [.allowAnimatedContent, .transitionCrossDissolve],
                animations: { self?.alpha = 1 },
                completion: nil)
        }
    }

    func hide() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0) { [weak self] in
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: [.allowAnimatedContent, .transitionCrossDissolve],
                animations: { self?.alpha = 0 },
                completion: nil)
        }
    }
    
    // MARK: - Private Implementation
    
    private func initUI() {
        alpha = 0
        setTitle(message, for: .normal)
        setTitleColor(.systemGray, for: .normal)
        tintColor = .systemGray3
        titleLabel?.numberOfLines = 1
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 22)
    }
    
    private func setUI() {
        titleEdgeInsets = .init(top: frame.height * 1.3, left: 0, bottom: 0, right: 0)
        titleLabel?.sizeToFit()
    }
}
