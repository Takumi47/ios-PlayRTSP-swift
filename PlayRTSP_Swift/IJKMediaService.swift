//
//  IJKMediaService.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import Foundation

class IJKMediaService {
    
    // MARK: - Singleton
    
    private init() {}
    static var shared = IJKMediaService()
    
    // MARK: - Properties
    
    var ijkMediaItems = [String: IJKMediaItem]()
    
    // MARK: - Methods
    
    func hasMedia(with uuid: String) -> Bool {
        return ijkMediaItems[uuid] != nil
    }
    
    func fetch(with uuid: String) -> IJKMediaItem? {
        return ijkMediaItems[uuid]
    }
    
    func setMedia(with uuid: String, url: String) {
        if removeMedia(with: uuid) { return }
        guard let newItem = IJKMediaItem(uuid: uuid, url: url) else { return }
        ijkMediaItems[uuid] = newItem
    }
    
    @discardableResult
    func removeMedia(with uuid: String) -> Bool {
        guard let item = ijkMediaItems[uuid] else { return false }
        item.stop()
        ijkMediaItems.removeValue(forKey: uuid)
        return true
    }
    
    func setSingleMedia(with uuid: String) {
        ijkMediaItems.forEach { (_uuid, item) in
            if _uuid != uuid {
                removeMedia(with: _uuid)
            }
        }
    }
}

