//
//  ProductViewCell.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-18.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var addingOrDeletingButton: UIStackView!
    @IBOutlet weak var pricePerQuantityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTheCell()
        // Initialization code
    }
    
    func configureTheCell() {
        productImage.layer.cornerRadius = 15
        addingOrDeletingButton.layer.cornerRadius = 17
        addingOrDeletingButton.isHidden = true
        
        addingButton.layer.cornerRadius = 17
    }
    @IBAction func addingToCart(_ sender: UIButton) {
    }
    
    @IBAction func deletingFromCart(_ sender: UIButton) {
    }
    
    
}
