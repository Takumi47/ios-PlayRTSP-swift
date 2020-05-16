//
//  IJKMediaItem.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import Foundation
import IJKMediaFramework

class IJKMediaItem {
    
    // MARK: - Properties
    
    var uuid: String!
    var url: String!
    
    var player: IJKFFMoviePlayerController?
    
    // MARK: - Lifecycle
    
    init?(uuid: String, url: String) {
        self.uuid = uuid
        self.url = url
        let options = IJKFFOptions.byDefault()
        options?.setFormatOptionValue("tcp", forKey: "rtsp_transport")
        
        guard let newPlayer = IJKFFMoviePlayerController(contentURLString: url, with: options) else { return nil }
        player = newPlayer
        player?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        player?.scalingMode = .aspectFit
        player?.shouldAutoplay = true
        play()
    }
    
    // MARK: - Methods
    
    func play() {
        player?.prepareToPlay()
    }
    
    func stop() {
        player?.view.removeFromSuperview()
        player?.stop()
        player = nil
    }
}
