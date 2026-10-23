//
//  Product.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}


struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let rating: Double
    let thumbnail: URL
}
