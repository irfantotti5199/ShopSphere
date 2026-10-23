//
//  FavouritesViewModel.swift
//  ShopSphere
//
//  Created by Irfan on 23/10/26.
//

import Foundation
import Combine

@MainActor
final class FavouritesViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    
    func toggleFavourites(_ product: Product) {
        if let index = products.firstIndex(where: {
            $0.id == product.id
        }) {
            products.remove(at: index)
        } else {
            products.append(product)
        }
    }
    
    func isFavourite(_ product: Product) -> Bool {
        products.contains(where: { $0.id == product.id })
    }
    
    
    func removeFavourite(_ product: Product) {
        products.removeAll(where: { $0.id == product.id})
    }
}

