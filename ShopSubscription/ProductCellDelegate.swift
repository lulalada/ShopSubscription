//
//  ProductCellDelegate.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-22.
//

import Foundation
protocol ProductCellDelegate: AnyObject
{
    func addToCart(product: Product, isAdded: Bool)
}
