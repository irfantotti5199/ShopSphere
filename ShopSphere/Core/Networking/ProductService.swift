//
//  ProductService.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case requestFailed
}

struct ProductService: ProductServiceProtocol {
   
    
    private let baseUrl = "https://dummyjson.com/products"
    
    private func request(path: String, queryItems: [URLQueryItem]) async throws -> ProductResponse {
        guard var components = URLComponents(string: "https://dummyjson.com/products\(path)") else {
            throw NetworkError.invalidResponse
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidResponse
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw NetworkError.requestFailed
        }
        return try JSONDecoder().decode(ProductResponse.self, from: data)
        
    }
    
    
    func fetchProducts(limit: Int = 20, skip: Int = 0) async throws -> ProductResponse {
        return try await request(
            path: "",
            queryItems: [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "skip", value: String(skip))
            ]
        )
    }
    
    func searchProducts(query: String, limit: Int, skip: Int) async throws -> ProductResponse {
        try await request(
            path: "/search",
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name:"limit", value: "\(limit)"),
                URLQueryItem(name: "skip", value: "\(skip)")
            ]
            )
    }

    
    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> ProductResponse {
        try await request(
            path: "/category/\(category)",
            queryItems: [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "skip", value: "\(skip)")
            ]
            )
    }
    
}
