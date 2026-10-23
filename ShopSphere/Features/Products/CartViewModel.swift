//
//  CartViewModel.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import Foundation
import Combine

@MainActor
final class CartViewModel: ObservableObject {
    @Published private(set) var items: [CartItem] = []
    
    var totalItems: Int {
        items.reduce(0) {
            $0 + $1.quantity
        }
    }
    
    var totalPrice: Double {
        items.reduce(0){
            $0 + $1.subtotal
        }
    }
    
    func add(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }
    
    
    func increaseQuantity(for item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id}) else {return}
        items[index].quantity += 1
    }
    
    func decreaseQuantity(for item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id}) else {return}
        
        if item.quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
        
    }
    
    
    func removeItem(_ item: CartItem) {
        items.removeAll(where: { $0.id == item.id })
    }
    
    func clearCart() {
        items.removeAll()
    }
    
}

