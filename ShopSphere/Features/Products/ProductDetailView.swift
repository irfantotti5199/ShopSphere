//
//  ProductDetailView.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    @EnvironmentObject private var cartViewModel: CartViewModel
    @EnvironmentObject private var favouritesViewModel: FavouritesViewModel
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: product.thumbnail) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 280)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 280)
                
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(product.title)
                        .font(.title2.bold())
                    
                    Button {
                        favouritesViewModel.toggleFavourites(product)
                    } label: {
                        Label(favouritesViewModel.isFavourite(product) ? "Remove from Favourites" : "Add to Favourites",systemImage: favouritesViewModel.isFavourite(product) ? "heart.fill" : "heart")
                    }
                    
                    Label(
                        String(format: "%.1f", product.rating),
                        systemImage: "star.fill"
                    )
                    .foregroundStyle(.orange)
                    
                    Text(product.price, format: .currency(code: "USD"))
                        .font(.title.bold())
                    
                    
                    Text("Category: \(product.category)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("Description")
                        .font(.headline)
                    
                    Text(product.description)
                        .foregroundStyle(.secondary)
                    
                    
                    Button {
                        cartViewModel.add(product)
                    } label: {
                        Label("Add to Cart", systemImage: "cart.badge.plus")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                        
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

