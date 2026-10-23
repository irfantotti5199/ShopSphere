//
//  ProductListView.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    
    @StateObject private var viewModel: ProductListViewModel

    init() {
        let context = PersistenceViewController.shared.container.viewContext

        _viewModel = StateObject(
            wrappedValue: ProductListViewModel(
                service: ProductService(),
                persistenceService: ProductPersistenceService(
                    context: context
                )
            )
        )
    }
    
    let columns = [
        GridItem(.flexible(), spacing:12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.products.isEmpty {
                    ProgressView("Loading Products...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else if let error = viewModel.errorMessage, viewModel.products.isEmpty {
                    errorView(error)
                } else if viewModel.products.isEmpty {
                    ContentUnavailableView("No Products", systemImage: "shippingbox", description: Text("No products are available"))
                } else {
                    categoryBar
                    productGrid
                    
                }
            }
            .navigationTitle("ShopSphere")
            .searchable(text: $viewModel.searchText, prompt: "Search products")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.loadProducts()
                }
            }
            .task {
                await viewModel.loadProducts()
            }
        }
    }
    
    private var productGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.products) { product in
                    NavigationLink {
                        ProductDetailView(product: product)
                    } label: {
                        ProductCardView(product: product)
                    }
                    .buttonStyle(.plain)
                    .onAppear {
                        guard product.id == viewModel.products.last?.id else {
                            return
                        }
                        
                        Task {
                            await viewModel.loadMoreProducts()
                        }
                    }
                }
            }
            .padding()
            
            if viewModel.isLoadingMore {
                ProgressView("Loading more products...")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
        }
        .refreshable {
            await viewModel.loadProducts()
        }
    }
    
    private var categoryBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                categoryButton("All", category: nil)
                categoryButton("Smartphones", category: "smartphones")
                categoryButton("Laptops", category: "laptops")
                categoryButton("Fragrances", category: "fragrances")
                categoryButton("Skincare", category: "skin-care")
            }
            .padding(.horizontal)
        }
    }
    
    private func categoryButton(_ title: String, category: String?) -> some View {
        Button {
            Task {
                await viewModel.selectedCategory(category)
            }
        } label: {
            Text(title)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    viewModel.selectedCategory == category ? Color.accentColor : Color.gray.opacity(0.15), in: Capsule()
                )
                .foregroundStyle(
                    viewModel.selectedCategory == category ?
                    Color.white : Color.primary
                )
        }
        .buttonStyle(.plain)
    }
    
    
    private func errorView(_ message: String) -> some View {
        ContentUnavailableView {
            Label("Couldn't Load Products", systemImage: "wifi.exclamationmark")
        } description: {
            Text(message)
        } actions: {
            Button("Try again") {
                Task {
                    await viewModel.loadProducts()
                }
            }
        }
    }
}

