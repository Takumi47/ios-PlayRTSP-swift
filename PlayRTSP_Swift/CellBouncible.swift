//
//  CellBouncible.swift
//  LiveAMHotel
//
//  Created by xander on 2019/8/19.
//  Copyright © 2019 com.wfe. All rights reserved.
//

import UIKit

private let kHighlightedFactor: CGFloat = 0.96

protocol CellBouncible {}

extension CellBouncible where Self: UIView {
    func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [.allowUserInteraction],
            animations: {
                if isHighlighted {
                    self.transform = .init(scaleX: kHighlightedFactor, y: kHighlightedFactor)
                } else {
                    self.transform = .identity
                }
        }, completion: completion)
    }
}

extension UICollectionViewCell: CellBouncible {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
}
