//
//  RTSPItemModel.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import Foundation
import RealmSwift

class RTSPItemModel: RxModel {
    
    // MARK: - Properties
    
    private static let provider: RealmProvider = .rtsp
    private static var _token: NotificationToken?
    private static var _items: Results<RTSPItem> = {
        return provider.realm.objects(RTSPItem.self)
            .sorted(byKeyPath: RTSPItem.Property.createdDate.rawValue, ascending: true)
    }()
    
    static var items: [RTSPItem] { Array(_items) }
    static var didUpdate: ChangesCallback? = nil {
        didSet {
            guard let didUpdate = didUpdate else {
                _token?.invalidate()
                return
            }
            _token = _items.observe { changes in
                switch changes {
                case .initial:
                    didUpdate([], [], [])
                case .update(_, let deletions, let insertions, let updates):
                    didUpdate(deletions, insertions, updates)
                case .error:
                    break
                }
            }
        }
    }
    
    // MARK: - Methods
    
    static func fetch(uuid: String) -> RTSPItem? {
        return provider.realm.object(ofType: RTSPItem.self, forPrimaryKey: uuid)
    }
    
    static func add(name: String, url: String) {
        let item = RTSPItem(name: name, url: url)
        try! provider.realm.write {
            provider.realm.add(item)
        }
    }
    
    static func delete(uuid: String) {
        guard let item = fetch(uuid: uuid) else { return }
        try! provider.realm.write {
            provider.realm.delete(item)
        }
    }
}
