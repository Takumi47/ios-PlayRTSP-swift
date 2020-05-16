//
//  RTSPViewCell.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

class RTSPViewCell: UICollectionViewCell {
    lazy var rtspView: RTSPView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview($0)
        NSLayoutConstraint.activate([
            $0.topAnchor.constraint(equalTo: contentView.topAnchor),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            $0.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            $0.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        return $0
    }(RTSPView())
    
    var isShaking: Bool = false {
        didSet {
            rtspView.setShakingEnabled(isShaking)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rtspView.clear()
    }
}
