//
//  ProductCollectionViewCell.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 23/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var savedValueLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8
        self.starImageView.isHidden = true
        
    }
    
    func setupCell(_ product: Product) {
        
        self.productTitleLabel.text = product.productFriendlyName
        self.savedValueLabel.text = product.moneybox.formatCurrency()
        self.planValueLabel.text = product.planValue.formatCurrency()
        
        if product.isFavourite {
            self.starImageView.isHidden = false
        }
    }
}
