//
//  CartViewController.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-22.
//

import UIKit

class CartViewController: UIViewController {
    
    weak var delegate:ProductDelegate?
    var productsInCart: [Product : Int] = [:]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CartItemViewCell", bundle: nil), forCellReuseIdentifier: "CartItemCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
//        if count == 0 {
//            productsInCart.removeValue(forKey: product)
//        } else {
//            productsInCart[product] = count
//        }
//        delegate?.checkingProductsInCart(products: productsInCart)
        
        
        productsInCart[product] = count
        
        if count == 0 {
            productsInCart.removeValue(forKey: product)
        }
        delegate?.checkingProductsInCart(products: productsInCart)
        tableView.reloadData()
        
    }
}
