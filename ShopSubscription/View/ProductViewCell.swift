//
//  ProductViewCell.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-18.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
    var product: Product!
    weak var delegate:ProductCellDelegate?
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addingOrDeletingButton: UIStackView!
    @IBOutlet weak var measureTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addingButton: UIButton!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureTheCell(passedProduct: Product) {
        product = passedProduct
        productImage.layer.cornerRadius = 15
        addingOrDeletingButton.layer.cornerRadius = 17
        addingOrDeletingButton.isHidden = true
        addingButton.layer.cornerRadius = 17
        
        nameLabel.text = product.name
        productImage.image = UIImage(named: product.photo)
        measureTypeLabel.text = product.measureType
        priceLabel.text = "\(product.price) ₸"
        
    }
    @IBAction func addingToCart(_ sender: UIButton) {
        if let quantityText = quantityLabel.text, let quantityInt = Int(quantityText) {
            if quantityInt == 0 {
                priceLabel.isHidden = true
                addingButton.isHidden = true
                addingOrDeletingButton.isHidden = false
                measureTypeLabel.text?.append(" • \(product.price) ₸")
            }
            let quantity = quantityInt + 1
            quantityLabel.text = String(quantity)
            delegate?.addToCart(product: product, isAdded: true)
        }

    }
    
    @IBAction func deletingFromCart(_ sender: UIButton) {
        if let quantityText = quantityLabel.text, let quantityInt = Int(quantityText) {
            let quantity = quantityInt - 1
            if quantity == 0 {
                priceLabel.isHidden = false
                addingButton.isHidden = false
                addingOrDeletingButton.isHidden = true
                measureTypeLabel.text = product.measureType
            }
            quantityLabel.text = String(quantity)
            delegate?.addToCart(product: product, isAdded: false)
        }
    }
    
    
}
