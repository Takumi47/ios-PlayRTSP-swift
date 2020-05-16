//
//  NibLoadable.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

protocol NibLoadable where Self: UIView {
    /**
     Load content view from nib file.
     
     Setup this view with nib:
     1. Load content view from nib (with the class name)
     2. Set owner to self
     3. Add it as a subview and fill edges with AutoLayout
     */
    func fromNib() -> UIView?
}

extension NibLoadable {
    @discardableResult
    func fromNib() -> UIView? {
        let name = "\(type(of: self))".components(separatedBy: ".")[0]
        let contentView = UINib(nibName: name, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.edges(to: self)
        return contentView
    }
}

