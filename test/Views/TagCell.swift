//
//  TagCell.swift
//  test
//
//  Created by Alexey Tregubov on 06.02.2023.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    
    var isActive = false
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    func updateState() {
        isActive = !isActive
    }
    
    func setActiveState() {
        backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        tagLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        isActive = true
    }
    
    func setUnActiveState() {
        backgroundColor = #colorLiteral(red: 0.9625495076, green: 0.9627466798, blue: 0.9688358903, alpha: 1)
        tagLabel.textColor = #colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
        isActive = false
    }
}
