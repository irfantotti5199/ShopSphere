//
//  ProductPersistenceService.swift
//  ShopSphere
//
//  Created by Irfan on 23/10/26.
//

import Foundation
import CoreData

@MainActor
final class ProductPersistenceService {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    
    func saveProducts(_ products: [Product]) throws {
        for product in products {
            let request = NSFetchRequest<CachedProduct>(
                entityName: "CachedProduct"
            )
            request.predicate = NSPredicate(format: "id == %d", product.id)
            let cachedProduct: CachedProduct
            if let existing = try context.fetch(request).first {
                cachedProduct = existing
            } else {
                cachedProduct = CachedProduct(context: context)
            }
            
            cachedProduct.id = Int64(product.id)
            cachedProduct.title = product.title
            cachedProduct.price = product.price
            cachedProduct.category = product.category
            cachedProduct.productDescription = product.description
            cachedProduct.thumbnail = product.thumbnail.absoluteString
            cachedProduct.rating = product.rating
            
            
        }
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func fetchCachedProducts() throws -> [Product] {
        let request = NSFetchRequest<CachedProduct>(
            entityName: "CachedProduct"
        )
        return try context.fetch(request).compactMap { cached in
            guard let title = cached.title, let productDescription = cached.productDescription,
                  let category = cached.category, let thumbnailString = cached.thumbnail,
                  let thumbnail = URL(string: thumbnailString) else {
                return nil
            }
            
            return Product(id: Int(cached.id), title: title , description: productDescription, category: category, price: cached.price, rating: cached.rating, thumbnail: thumbnail)
        }
    }
}
