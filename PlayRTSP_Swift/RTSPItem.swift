//
//  RTSPItem.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class RTSPItem: Object {
    
    // MARK: - Properties
    
    enum Property: String {
        case uuid, createdDate
    }
    
    dynamic var uuid = UUID().uuidString
    dynamic var name = ""
    dynamic var url = ""
    dynamic var createdDate = Date()
    
    // MARK: - Lifecycle
    
    convenience init(name: String, url: String) {
        self.init()
        self.name = name
        self.url = url
    }
    
    // MARK: - Override
    
    override class func primaryKey() -> String? {
        return Property.uuid.rawValue
    }
}
