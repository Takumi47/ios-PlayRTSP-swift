//
//  UICollectionView+.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

extension IndexPath {
    static func fromRow(_ row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}

extension UICollectionView {
    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
        if deletions.isEmpty, insertions.isEmpty, updates.isEmpty {
            /* initial */
            UIView.transition(
                with: self,
                duration: 0.33,
                options: .transitionCrossDissolve,
                animations: { self.reloadData() },
                completion: nil)
        } else {
            /* update */
            self.alpha = 0.7
            UIView.transition(
                with: self,
                duration: 0.33,
                options: .transitionCrossDissolve,
                animations: {
                    self.alpha = 1
                    self.performBatchUpdates({
                        self.deleteItems(at: deletions.map(IndexPath.fromRow))
                        self.insertItems(at: insertions.map(IndexPath.fromRow))
                        self.reloadItems(at: updates.map(IndexPath.fromRow))
                    }, completion: nil)
            },
                completion: nil)
        }
    }
}

