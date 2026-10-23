//
//  ProductServiceProtocol.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(limit: Int, skip: Int) async throws -> ProductResponse
    
    func searchProducts(query: String, limit: Int, skip: Int) async throws -> ProductResponse
    
    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> ProductResponse
}
