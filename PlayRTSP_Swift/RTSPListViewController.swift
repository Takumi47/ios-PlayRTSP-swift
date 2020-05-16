//
//  RTSPListViewController.swift
//  PlayRTSP_Swift
//
//  Created by xander on 2020/5/16.
//  Copyright © 2020 xander. All rights reserved.
//

import UIKit

private let kCellReuseId = "Cell"
private let kNumberOfItemsInARow: CGFloat = 2
private let kItemHorizontalOffset: CGFloat = 16
private let kItemHeightByWidthRatio: CGFloat = 180/180
private let kMinimumInteritemSpacing: CGFloat = 8

class RTSPListViewController: ViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var addRTSPButton: XButton!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var trashButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(onTrashButtonTapped))
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTapped))
    }()
    
    private var tapGesture: UITapGestureRecognizer!
    
    override var isEditing: Bool {
        didSet {
            addButton.isEnabled = !isEditing
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    // MARK: - Selector
    
    @IBAction func onAddButtonTapped() {
        addRTSP()
    }
    
    @objc func onTrashButtonTapped() {
        if RTSPItemModel.items.isEmpty { return }
        navigationItem.rightBarButtonItem = doneButton
        isEditing = true
    }
    
    @objc func onDoneButtonTapped() {
        navigationItem.rightBarButtonItem = trashButton
        isEditing = false
    }
    
    @objc func tapRTSP(_ gesture: UITapGestureRecognizer) {
        if isEditing { return }

        /* get indexPath */
        let p1 = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: p1) else { return }
        
        /* check tap area */
        guard let cell = collectionView.cellForItem(at: indexPath) as? RTSPViewCell else { return }
        let p2 = gesture.location(in: cell)
        if cell.rtspView.contentView.frame.contains(p2) {
            
            /* close all other media */
            let item = RTSPItemModel.items[indexPath.item]
//            IJKMediaService.shared.setSingleMedia(with: item.uuid)

            /* play selected media */
//            if IJKMediaService.shared.hasMedia(with: item.uuid) == false {
//                IJKMediaService.shared.setMedia(with: item.uuid, url: item.url)
//            }

            performSegue(withIdentifier: .detail, sender: (cell.heroID, item.uuid))
        }
    }
    
    // MARK: - Private Implementation
    
    private func initUI() {
        navigationItem.rightBarButtonItem = trashButton
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = kMinimumInteritemSpacing
            layout.sectionInset = .init(top: 24, left: kItemHorizontalOffset, bottom: 64, right: kItemHorizontalOffset)
        }

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRTSP))
        collectionView.addGestureRecognizer(tapGesture)
        collectionView.alwaysBounceVertical = false
        collectionView.register(RTSPViewCell.self, forCellWithReuseIdentifier: kCellReuseId)
    }
    
    private func addObservers() {
        RTSPItemModel.didUpdate = { [weak self] (deleted, inserted, updated) in
            self?.collectionView.applyChanges(deletions: deleted, insertions: inserted, updates: updated)
        }
    }
    
    private func removeObservers() {
        RTSPItemModel.didUpdate = nil
    }
    
    private func addRTSP() {
        var nameField = UITextField()
        var urlField = UITextField()
        let alert = UIAlertController(title: "Add RTSP", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let name = nameField.text, !name.isEmpty, let url = urlField.text, !url.isEmpty {
                RTSPItemModel.add(name: name, url: url)
            }
        }
        addAction.isEnabled = false
        alert.addAction(addAction)
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: .main) { _ in
            if nameField.text?.isEmpty == false && urlField.text?.isEmpty == false {
                addAction.isEnabled = true
            }
        }
        
        alert.addTextField { field in
            nameField = field
            nameField.placeholder = "Name"
            nameField.text = GlobalConstants.defaultName
        }
        
        alert.addTextField { field in
            urlField = field
            urlField.placeholder = "rtsp://"
            urlField.text = GlobalConstants.defaultURL
        }
        
        present(alert, animated: true) {
            nameField.becomeFirstResponder()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension RTSPListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? RTSPViewCell else { return }
        let item = RTSPItemModel.items[indexPath.item]
        
        cell.isShaking = isEditing
        cell.heroID = "rtsp_\(indexPath.item)"
        cell.rtspView.object = item
        cell.rtspView.playHandler = play(uuid:url:)
        cell.rtspView.deletionHandler = delete(uuid:)
    }
    
    private func play(uuid: String, url: String) {
        if isEditing { return }
//        IJKMediaService.shared.setMedia(with: uuid, url: url)
        collectionView.reloadData()
    }
    
    private func delete(uuid: String) {
//        IJKMediaService.shared.removeMedia(with: uuid)
        RTSPItemModel.delete(uuid: uuid)
    }
}

// MARK: - UICollectionViewDataSource

extension RTSPListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = RTSPItemModel.items.count
        defer {
            addRTSPButton.isVisible(count == 0)
            if count == 0 { onDoneButtonTapped() }
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: kCellReuseId, for: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RTSPListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpace = 2 * kItemHorizontalOffset + kNumberOfItemsInARow * kMinimumInteritemSpacing
        let width = (collectionView.bounds.width - totalSpace) / kNumberOfItemsInARow
        let height = width * kItemHeightByWidthRatio
        return  CGSize(width: width, height: height)
    }
}

// MARK: - Navigation

extension RTSPListViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case detail
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = segueIdentifier(for: segue)
        guard case .detail = id,
            let (heroID, uuid) = sender as? (String, String),
            let destVC = segue.destination as? RTSPViewController else { return }
        destVC.view.heroID = heroID
        destVC.uuid = uuid
    }
}
