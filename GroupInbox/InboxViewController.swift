//
//  InboxViewController.swift
//  GroupInbox
//
//  Created by 정지승 on 2023/09/11.
//

import UIKit

import Kingfisher

class InboxViewController: UIViewController {
    let imageView = UIImageView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let collectionViewItems = InboxGroup.mock
    private var isCollapsed: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isCollapsed = collectionViewItems.map({ $0.items.count > 1})
        
        setUserInterface()
    }
    
    private func setUserInterface() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "backgroundImage")
        imageView.contentMode = .scaleToFill


        collectionView.backgroundView = imageView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(InboxCell.self, forCellWithReuseIdentifier: InboxCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

extension InboxViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isCollapsed[indexPath.section] && indexPath.item > 3 { return .zero }
        return .init(width: collectionView.frame.width - (48 + (isCollapsed[indexPath.section] ? CGFloat(indexPath.item) * 10.0 : 0)), height: 81)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        isCollapsed[section] ? -78 : 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionViewItems[indexPath.section].items.count > 1 else { return }
        isCollapsed[indexPath.section].toggle()
        
        UIView.animate(withDuration: 2.5, delay: .zero, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            collectionView.reloadSections([indexPath.section])
        }
    }
}

extension InboxViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionViewItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewItems[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: InboxCell.identifier, for: indexPath)
        
        if let inboxCell = reusableCell as? InboxCell {
            inboxCell.setContent(item: collectionViewItems[indexPath.section].items[indexPath.item])
            inboxCell.isCollapsed = isCollapsed[indexPath.section]
        }
        
        reusableCell.layer.zPosition = CGFloat(collectionViewItems[indexPath.section].items.count - indexPath.item)
        
        return reusableCell
    }
}
