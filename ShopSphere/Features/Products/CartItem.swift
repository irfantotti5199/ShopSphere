//
//  CartItem.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import Foundation

struct CartItem: Identifiable {
    let product: Product
    var quantity: Int
    
    var id: Int {
        product.id
    }
    
    var subtotal: Double {
        product.price * Double(quantity)
    }
}
