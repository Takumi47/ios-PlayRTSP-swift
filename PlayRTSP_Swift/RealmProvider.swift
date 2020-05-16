//
//  RealmProvider.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import Foundation
import RealmSwift

private let kSchemaVersion: UInt64 = 1

class RealmProvider {
    
    // MARK: - Properties
    
    private let configuration: Realm.Configuration
    
    var realm: Realm { try! Realm(configuration: configuration) }
    
    // MARK: - Lifecycle
    
    private init(config: Realm.Configuration) {
        self.configuration = config
    }
    
    // MARK: - Library RTSP Realm
    
    private static let rtspConfig = Realm.Configuration(
        fileURL: try! Path.inLibrary("rtsp.realm"),
        encryptionKey: nil,
        schemaVersion: kSchemaVersion,
        objectTypes: [RTSPItem.self])
    
    static var rtsp: RealmProvider = {
        RealmProvider(config: rtspConfig)
    }()
}
