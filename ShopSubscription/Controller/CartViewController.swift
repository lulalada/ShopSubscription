//
//  CartViewController.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-22.
//

import UIKit

class CartViewController: UIViewController {
    
    weak var delegate: ProductDelegate?
    var totalPrice = 0
    var productsInCart: [Product : Int] = [:]
    var shouldBlockSegue: Bool = true
    
    @IBOutlet weak var goToSubscriptionButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CartItemViewCell", bundle: nil), forCellReuseIdentifier: "CartItemCell")
        findTotalPrice()
        totalPriceLabel.text?.append(" \(totalPrice) ₸")
        goToSubscriptionButton.layer.cornerRadius = 10
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func findTotalPrice() {
        
        for products in productsInCart {
            totalPrice = totalPrice + (products.key.price * products.value)
        }
        if totalPrice == 0 {
            shouldBlockSegue = true
        } else {
            shouldBlockSegue = false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            if identifier == "goToSubscriptionPage" {
                if shouldBlockSegue {
                    return false
                }
                return true
            }
        return true
        }

}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)  as! CartItemViewCell
        let product = Array(productsInCart.keys)[indexPath.row]
        let count = Array(productsInCart.values)[indexPath.row]
        cell.configureTheCell(passedProduct: product, passedCount: count)
        cell.delegate = self
        return cell
    }
    
    
}


//MARK: - CartItemCellDelegate

extension CartViewController: CartItemCellDelegate {
    func addToCart(product: Product, isAdded: Bool, count: Int) {

        
        productsInCart[product] = count
        
        if count == 0 {
            productsInCart.removeValue(forKey: product)
        }
        delegate?.checkingProductsInCart(products: productsInCart)
        tableView.reloadData()
        
    }
}
