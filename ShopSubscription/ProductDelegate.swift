//
//  ProductDelegate.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-23.
//

import Foundation
protocol ProductDelegate: AnyObject
{
    func checkingProductsInCart(products: [Product: Int])
}
