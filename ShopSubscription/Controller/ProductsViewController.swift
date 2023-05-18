//
//  ProductsViewController.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-18.
//

import UIKit

class ProductsViewController: UIViewController {
    var products: [Product] = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        configureProducts()
    }
    
    func configureProducts() {
        products.append(Product(name: "молоко Амиран детское", price: 250, availability: true, weight: 0.23, photo: "milk_baby"))
    }
    
}


//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductViewCell
        cell.productImage.image = UIImage(named: products[indexPath.row].photo)
        
        return cell
    }
    
    
}
