//
//  ProductViewCell.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-18.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
    var product: Product!
    var count = 0
    weak var delegate:ProductCellDelegate?
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addingOrDeletingButton: UIStackView!
    @IBOutlet weak var measureTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addingButton1: UIButton!
    @IBOutlet weak var deletingButton: UIButton!
    @IBOutlet weak var addingButton: UIButton!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureTheCell(passedProduct: Product, passedCount: Int) {
        product = passedProduct
        count = passedCount
        productImage.layer.cornerRadius = 15
        productImage.image = UIImage(named: product.photo)
        nameLabel.text = product.name
        quantityLabel.text = String(count)
        priceLabel.text = "\(product.price) ₸"
        addingButton.layer.cornerRadius = 17
        addingOrDeletingButton.layer.cornerRadius = 17
        if count == 0 {
            priceLabel.isHidden = false
            addingButton.isHidden = false
            addingOrDeletingButton.isHidden = true
            measureTypeLabel.text = product.measureType
            
        } else {
            priceLabel.isHidden = true
            addingButton.isHidden = true
            addingOrDeletingButton.isHidden = false
            measureTypeLabel.text = ("\(product.measureType) • \(product.price) ₸")
        }
        
        if product.availability == false {
            addingButton.isEnabled = false
            addingButton1.isEnabled = false
            deletingButton.isEnabled = false
            productImage.alpha = 0.3
        } else {
            addingButton.isEnabled = true
            addingButton1.isEnabled = true
            deletingButton.isEnabled = true
            productImage.alpha = 1.0
        }
        
    }
    @IBAction func addingToCart(_ sender: UIButton) {
        if let quantityText = quantityLabel.text, let quantityInt = Int(quantityText) {
            if quantityInt == 0 {
                priceLabel.isHidden = true
                addingButton.isHidden = true
                addingOrDeletingButton.isHidden = false
                measureTypeLabel.text = ("\(product.measureType) • \(product.price) ₸")
            }
            let quantity = quantityInt + 1
            quantityLabel.text = String(quantity)
            delegate?.addToCart(product: product, isAdded: true, count: quantity)
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
            delegate?.addToCart(product: product, isAdded: false, count: quantity)
        }
    }
    
    
}
