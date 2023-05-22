//
//  ProductsViewController.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-18.
//

import UIKit

class ProductsViewController: UIViewController {
    let products = [Product(id: 1, name: "Молоко Амиран детское 230 мл", price: 250, availability: true, photo: "milk_baby", measureType: "шт"),
                    Product(id: 2, name: "Киви", price: 1400, availability: true, photo: "kiwi", measureType: "кг"),
                    Product(id: 3, name: "Помидоры черри 200 г", price: 250, availability: true, photo: "tomato_cherry", measureType: "шт"),
                    Product(id: 4, name: "Зеленые яблоки", price: 945, availability: true, photo: "apples_green", measureType: "кг"),
                    Product(id: 5, name: "Малина 400 г", price: 250, availability: true, photo: "berries", measureType: "шт"),
                    Product(id: 6, name: "Киви желтые", price: 3440, availability: true, photo: "kiwi_yellow", measureType: "кг")]
    
    var filteredProducts: [Product] = []
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
        //cell.productImage.image = UIImage(named: products[indexPath.row].photo)
        
        cell.configureTheCell(passedProduct: filteredProducts[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
}


//MARK: - UISearchBarDelegate

extension ProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProducts = []
        if searchText == "" {
            filteredProducts = products
        }
        for product in products {
            if product.name.uppercased().contains(searchText.uppercased()) {
                filteredProducts.append(product)
            }
        }
        self.collectionView.reloadData()
    }
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
   
}

extension ProductsViewController: ProductCellDelegate {
    func addToCart(product: Product, isAdded: Bool) {
        if isAdded == true {
            if let count = productsInCart[product] {
                productsInCart[product] = count + 1
                
            } else {
                productsInCart[product] = 1
            }
        } else {
            if var count = productsInCart[product] {
                count = count - 1
                productsInCart[product] = count
                if count == 0 {
                    productsInCart.removeValue(forKey: product)
                }
            }
        }
        
    }
}
