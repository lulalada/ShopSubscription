//
//  ProductsViewController.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-18.
//

import UIKit

class ProductsViewController: UIViewController {
    let products = [Product(id: 1, name: "Молоко Амиран детское 230 мл", price: 250, availability: true, photo: "milk_baby", measureType: "шт") : 0,
                    Product(id: 2, name: "Киви", price: 1400, availability: true, photo: "kiwi", measureType: "кг") : 0,
                    Product(id: 3, name: "Помидоры черри 200 г", price: 250, availability: true, photo: "tomato_cherry", measureType: "шт") : 0,
                    Product(id: 4, name: "Зеленые яблоки", price: 945, availability: true, photo: "apples_green", measureType: "кг") : 0,
                    Product(id: 5, name: "Малина 400 г", price: 250, availability: true, photo: "berries", measureType: "шт") : 0,
                    Product(id: 6, name: "Киви желтые", price: 3440, availability: true, photo: "kiwi_yellow", measureType: "кг") : 0]
    
    var filteredProducts: [Product: Int] = [:]
    var productsInCart: [Product : Int] = [:]
    var isSearching = false
    @IBOutlet weak var goToCartButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        //configureProducts()
        filteredProducts = products
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        collectionView.keyboardDismissMode = .onDrag
        goToCartButton.layer.cornerRadius = 10
    }
    
    
//    func configureProducts() {
//        products.append(Product(name: "Молоко Амиран детское 230 мл", price: 250, availability: true, photo: "milk_baby", measureType: "шт"))
//        products.append(Product(name: "Киви", price: 1400, availability: true, photo: "kiwi", measureType: "кг"))
//        products.append(Product(name: "Помидоры черри 200 г", price: 250, availability: true, photo: "tomato_cherry", measureType: "шт"))
//        products.append(Product(name: "Зеленые яблоки", price: 945, availability: true, photo: "apples_green", measureType: "кг"))
//        products.append(Product(name: "Малина 400 г ", price: 250, availability: true, photo: "berries", measureType: "шт"))
//        products.append(Product(name: "Киви желтые", price: 3440, availability: true, photo: "kiwi_yellow", measureType: "кг"))
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let secondVC = segue.destination
          as? CartViewController else {return}
        
        
        if segue.identifier == "goToCart" {
            secondVC.productsInCart = productsInCart
            secondVC.delegate = self
        }
        
    }
    
}


//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductViewCell
        let product = Array(filteredProducts.keys)[indexPath.row]
        let count = Array(filteredProducts.values)[indexPath.row]
        cell.configureTheCell(passedProduct: product, passedCount: count)
        cell.delegate = self
        return cell
    }
    
    
}


//MARK: - UISearchBarDelegate

extension ProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProducts = [:]
        if searchText == "" {
            filteredProducts = products
        }
        for product in products {
            if product.key.name.uppercased().contains(searchText.uppercased()) {
                filteredProducts[product.key] = product.value
            }
        }
        self.collectionView.reloadData()
    }
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
   
}

//MARK: - ProductCellDelegate

extension ProductsViewController: ProductCellDelegate {
    func addToCart(product: Product, isAdded: Bool, count: Int) {
        if count == 0 {
            productsInCart.removeValue(forKey: product)
            
        } else {
            productsInCart[product] = count
        }
        filteredProducts[product] = count
        collectionView.reloadData()


//
//        if isAdded == true {
//            if let count = productsInCart[product] {
//                productsInCart[product] = count + 1
//
//            } else {
//                productsInCart[product] = 1
//            }
//        } else {
//            if var count = productsInCart[product] {
//                count = count - 1
//                productsInCart[product] = count
//                if count == 0 {
//                    productsInCart.removeValue(forKey: product)
//                }
//            }
//        }
        
    }
}
//MARK: - ProductDelegate
extension ProductsViewController: ProductDelegate {
    func checkingProductsInCart(products: [Product : Int]) {
        for key in productsInCart.keys {
            if products[key] == nil {
                filteredProducts[key] = 0
            }
        }
        productsInCart = products
        for product in products {
            
            filteredProducts[product.key] = product.value
            if product.value == 0 {
                print("i am 0")
            }
        }
        collectionView.reloadData()
    }
}
