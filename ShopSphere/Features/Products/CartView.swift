//
//  CartView.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject private var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if cartViewModel.items.isEmpty {
                    ContentUnavailableView("Your Cart Is Empty", systemImage: "cart", description: Text("Add some products to get started.")
                                           
                    )
                } else {
                    cartItemList
                }
            }.navigationTitle("My Cart")
        }
    }
    
    private var cartItemList: some View {
        List {
            ForEach(cartViewModel.items) { item in
                HStack(spacing: 12) {
                    AsyncImage(url: item.product.thumbnail) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width:75, height: 75)
                    
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.product.title)
                            .font(.headline)
                            .lineLimit(2)
                        
                        Text(item.subtotal, format: .currency(code: "USD"))
                            .font(.subheadline.bold())
                        
                        HStack(spacing:16) {
                            Button {
                                cartViewModel.decreaseQuantity(for: item)
                            } label: {
                                Image(systemName: "minus.circle")
                            }
                            
                            Text("\(item.quantity)")
                                .monospacedDigit()
                            
                            Button {
                                cartViewModel.increaseQuantity(for: item)
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                        .buttonStyle(.plain)
                        
                    }
                                    
                }
                .padding(.vertical, 6)

            }
            .onDelete { offset in
                for index in offset {
                    cartViewModel.removeItem(cartViewModel.items[index])
                }
            }
            
            Section {
                HStack {
                    Text("Total (\(cartViewModel.totalItems) items)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(cartViewModel.totalPrice, format: .currency(code: "USD"))
                        .font(.headline)
                }
                
                Button(role:.destructive) {
                    cartViewModel.clearCart()
                } label: {
                    Text("Clear Cart")
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

