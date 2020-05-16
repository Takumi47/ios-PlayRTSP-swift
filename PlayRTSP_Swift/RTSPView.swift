//
//  RTSPView.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

class RTSPView: UIView, NibLoadable {
    
    // MARK: - Properties
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var object: RTSPItem? {
        didSet {
            guard let obj = object else { return }
            nameLabel.text = obj.name
            urlLabel.text = obj.url

            if let media = IJKMediaService.shared.fetch(with: obj.uuid) {
                playButton.setImage(UIImage.stop, for: .normal)
                if let playerView = media.player?.view {
                    media.player?.scalingMode = .aspectFill
                    playerView.frame = contentView.bounds
                    contentView.autoresizesSubviews = true
                    contentView.addSubview(playerView)
                }
            } else {
                playButton.setImage(UIImage.play, for: .normal)
                contentView.subviews.forEach { $0.removeFromSuperview() }
            }
        }
    }

    var playHandler: ((String, String) -> Void)?
    var deletionHandler: ((String) -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fromNib()
        commonSetup()
    }
    
    // MARK: - Selector
    
    @IBAction func onPlayButtonTapped() {
        guard let obj = object else { return }
        playHandler?(obj.uuid, obj.url)
    }
    
    @IBAction func onDeleteButtonTapped() {
        guard let obj = object else { return }
        deletionHandler?(obj.uuid)
    }
    
    // MARK: - Methods

    func setShakingEnabled(_ isShaking: Bool) {
        UIView.transition(with: deleteButton, duration: 0.6, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.deleteButton.isHidden = !isShaking
        })
        
        if isShaking {
            deleteButton.startShaking()
            containerView.startShaking()
        } else {
            deleteButton.stopShaking()
            containerView.stopShaking()
        }
    }
    
    func clear() {
        object = nil
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Private Implementation
    
    private func commonSetup() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 5
        layer.addShadow(.init(width: 2, height: 4), 0.6, 2, .darkGray)
    }
}

