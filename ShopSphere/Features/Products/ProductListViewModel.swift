//
//  ProductListViewModel.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import Foundation
import Combine
import CoreData

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    @Published private(set) var errorMessage: String?
    
    
    @Published var searchText = ""
    @Published var selectedCategory: String?
    
    private let persistenceService: ProductPersistenceService
    private let pageSize = 20
    private var total = 0
    private var skip = 0
    
    private var hasMoreProducts: Bool {
        skip < total
    }
    
    private let service: any ProductServiceProtocol
    
    init(service: any ProductServiceProtocol, persistenceService: ProductPersistenceService) {
        self.service = service
        self.persistenceService = persistenceService
    }
    
    func loadProducts() async {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        errorMessage = nil
        skip = 0
        total = 0
        products = []
        
        defer {
            isLoading = false
        }
        
        do {
            
            let response = try await fetchPage(skip: 0)
            products = response.products
            skip = response.products.count
            total = response.total
            
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, selectedCategory == nil {
                do {
                    try persistenceService.saveProducts(response.products)
                } catch {
                    print("Product cacheing failed. \(error)")
                }
            }
        } catch {
            let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            if query.isEmpty, selectedCategory == nil {
                do {
                    let cachedProducts = try persistenceService.fetchCachedProducts()
                    
                    if !cachedProducts.isEmpty {
                        products = cachedProducts
                        skip = cachedProducts.count
                        total = cachedProducts.count
                        return
                    }
                } catch {
                    print("Loading cached products failed \(error)")
                }
            }
            errorMessage = error.localizedDescription
        }
    }
    
    func loadMoreProducts() async {
        guard !isLoading,!isLoadingMore,hasMoreProducts else {
            return
        }
        isLoadingMore = true
        defer {
            isLoadingMore = false
        }
        
        do {
            let response = try await fetchPage(skip:skip)
            products.append(contentsOf: response.products)
            skip += response.products.count
            total += response.total
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func fetchPage(skip: Int) async throws -> ProductResponse {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !query.isEmpty {
            return try await service.searchProducts(query: query, limit: pageSize, skip: skip)
        }
        
        if let category = selectedCategory {
            return try await service.fetchProducts(category: category, limit: pageSize, skip: skip)
        }
        
        return try await service.fetchProducts(limit: pageSize, skip: skip)
    }
    
    func selectedCategory(_ category: String?) async {
        selectedCategory = category
        await loadProducts()
    }
}
