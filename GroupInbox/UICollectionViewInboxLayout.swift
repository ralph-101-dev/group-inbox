//
//  UICollectionViewInboxLayout.swift
//  GroupInbox
//
//  Created by ralph-L on 2023/09/16.
//

import UIKit

final class UICollectionViewInboxLayout: UICollectionViewLayout {
    private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentSize = CGSize.zero
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView,
              let delegate = collectionView.delegate as? UICollectionViewInboxGroupDelegate else { return }
        
        cachedAttributes.removeAll()
        var offsetY = CGFloat.zero
        
        // FIXME: set start index by contentsOffset
        for sectionIndex in 0..<collectionView.numberOfSections {
            let sectionInset = delegate.collectionView(collectionView, layout: self, insetForSectionAt: sectionIndex)
            let isSectionCollapsed = delegate.collectionView(collectionView, layout: self, isCollapsed: sectionIndex)
            let maximumCollapsedCount = delegate.collectionViewMaximumCollapsedCount(collectionView, layout: self)
            
            offsetY += sectionInset.bottom
            
            for itemIndex in 0..<collectionView.numberOfItems(inSection: sectionIndex) {
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                let cellSize = delegate.collectionView(collectionView, layout: self, sizeForItemAt: indexPath)
                let layout = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let lineSpacing = delegate.collectionView(collectionView, layout: self, minimumLineSpacingForSectionAt: sectionIndex)
                var finalFrame = CGRect(origin: CGPoint(x: (collectionView.frame.width - cellSize.width) / 2, y: offsetY + lineSpacing), size: cellSize)
                finalFrame = finalFrame.inset(by: UIEdgeInsets(top: 0, left: sectionInset.left, bottom: 0, right: sectionInset.right))
                
                if isSectionCollapsed && itemIndex > 0 {
                    finalFrame = finalFrame.insetBy(dx: CGFloat(5 * min(itemIndex, maximumCollapsedCount)), dy: itemIndex > maximumCollapsedCount ? 0 : 5)
                    finalFrame = finalFrame.offsetBy(dx: 0, dy: -(finalFrame.height + lineSpacing))
                }

                layout.frame = finalFrame
                cachedAttributes.append(layout)
                
                offsetY = finalFrame.maxY
            }
            offsetY += sectionInset.bottom
        }
        
        contentSize = CGSize(width: collectionView.frame.width, height: offsetY + 150)
        var collectionViewBounds = collectionView.bounds
        collectionViewBounds.size = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height - 150)
        
        for attribute in cachedAttributes {
            if attribute.frame.minY > collectionViewBounds.maxY {
                let fraction = (attribute.frame.minY - collectionViewBounds.maxY) / 150
                attribute.frame = attribute.frame.offsetBy(dx: 0.0, dy: -(150 * fraction)).insetBy(dx: 60 * min(fraction, 1), dy: 30 * min(fraction, 1))
            }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cachedAttributes.first(where: { $0.indexPath == indexPath })
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cachedAttributes.filter { rect.intersects($0.frame) }
    }
    
    override var collectionViewContentSize: CGSize {
        contentSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView else { return false }
        return !newBounds.origin.equalTo(collectionView.bounds.origin)
    }
}

protocol UICollectionViewInboxGroupDelegate: UICollectionViewDelegateFlowLayout {
    func collectionViewMaximumCollapsedCount(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> Int
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, isCollapsed section: Int) -> Bool
}
