//
//  Product.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-18.
//

import Foundation
struct Product: Hashable {
    let id: Int
    let name: String
    let price: Int
    let availability: Bool
    let photo: String
    let measureType: String
}
