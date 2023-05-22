//
//  CartItemViewCell.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-20.
//

import UIKit

class CartItemViewCell: UITableViewCell {
    
    var product: Product!
    var count = 0
    weak var delegate:CartItemCellDelegate?
    
    @IBOutlet weak var addingOrDeletingButton: UIStackView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTheCell(passedProduct: Product, passedCount: Int) {
        product = passedProduct
        count = passedCount
        productImage.layer.cornerRadius = 15
        addingOrDeletingButton.layer.cornerRadius = 17
    
        
        nameLabel.text = product.name
        productImage.image = UIImage(named: product.photo)
        costLabel.text = "\(product.price * count) ₸"
        quantityLabel.text = "\(count) \(product.measureType)"
        
    }
    
    @IBAction func addingToCart(_ sender: UIButton) {
        count = count + 1
        quantityLabel.text = String(count)
        costLabel.text = "\(product.price * count) ₸"
        delegate?.addToCart(product: product, isAdded: true, count: count)
    }
    
    @IBAction func deletingFromCart(_ sender: UIButton) {
        count = count - 1
        delegate?.addToCart(product: product, isAdded: false, count: count)
        quantityLabel.text = "\(count) \(product.measureType)"
        costLabel.text = "\(product.price * count) ₸"
        
    }
    
}
