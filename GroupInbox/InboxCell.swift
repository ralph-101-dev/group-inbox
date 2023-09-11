//
//  InboxCell.swift
//  GroupInbox
//
//  Created by 정지승 on 2023/09/11.
//

import UIKit
import SwiftUI

import Kingfisher

final class InboxCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
    
    private let title = UILabel()
    private let message = UILabel()
    private let iconImage = UIImageView()
    
    var isCollapsed = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(item: InboxItem) {
        self.title.text = item.title
        self.message.text = item.message
    }
    
    private func setUserInterface() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .init(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 15
        self.backgroundColor = .gray
        
        iconImage.backgroundColor = .green
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.layer.cornerRadius = 8
        iconImage.clipsToBounds = true
        self.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 38),
            iconImage.heightAnchor.constraint(equalToConstant: 38),
            iconImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        title.font = .boldSystemFont(ofSize: 16)
        
        message.font = .systemFont(ofSize: 16)
        
        let contentContaienr = UIStackView(arrangedSubviews: [
            title,
            message
        ])
        contentContaienr.axis = .vertical
        self.addSubview(contentContaienr)
        contentContaienr.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentContaienr.leftAnchor.constraint(equalTo: self.iconImage.rightAnchor, constant: 10),
            contentContaienr.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14),
            contentContaienr.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}

final class CollepsedInboxCell: UICollectionViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
    
    let title = UILabel()
    let message = UILabel()
    let iconImage = UIImageView()
    
    var collapsedItemCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(item: InboxItem) {
        self.title.text = item.title
        self.message.text = item.message
    }
    
    private func setUserInterface() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.backgroundColor = .gray
        
        iconImage.backgroundColor = .green
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.layer.cornerRadius = 8
        iconImage.clipsToBounds = true
        self.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 38),
            iconImage.heightAnchor.constraint(equalToConstant: 38),
            iconImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        title.font = .boldSystemFont(ofSize: 16)
        
        message.font = .systemFont(ofSize: 16)
        
        let contentContaienr = UIStackView(arrangedSubviews: [
            title,
            message
        ])
        contentContaienr.axis = .vertical
        self.addSubview(contentContaienr)
        contentContaienr.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentContaienr.leftAnchor.constraint(equalTo: self.iconImage.rightAnchor, constant: 10),
            contentContaienr.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14),
            contentContaienr.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
