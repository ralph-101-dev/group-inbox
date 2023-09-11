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
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewInboxLayout())
    let collectionViewItems = InboxGroup.mock
    private var sectionCollapsedState: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionCollapsedState = collectionViewItems.map({ $0.items.count > 1})
        
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
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

extension InboxViewController: UICollectionViewInboxGroupDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 20, height: 81)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 10, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionViewItems[indexPath.section].items.count > 1 else { return }
        sectionCollapsedState[indexPath.section].toggle()

        UIView.animate(withDuration: 0.6, delay: .zero, usingSpringWithDamping: 0.95, initialSpringVelocity: 0.5) {
            collectionView.performBatchUpdates(nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, isCollapsed section: Int) -> Bool {
        sectionCollapsedState[section]
    }
    
    func collectionViewMaximumCollapsedCount(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> Int {
        3
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
            inboxCell.isCollapsed = sectionCollapsedState[indexPath.section]
        }
        
        reusableCell.layer.zPosition = CGFloat((collectionViewItems.count - indexPath.section) * 1000 + collectionViewItems[indexPath.section].items.count - indexPath.item)
        
        return reusableCell
    }
}
