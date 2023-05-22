//
//  CartItemCellDelegate.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-23.
//

import Foundation
protocol CartItemCellDelegate: AnyObject
{
    func addToCart(product: Product, isAdded: Bool, count: Int)
}
