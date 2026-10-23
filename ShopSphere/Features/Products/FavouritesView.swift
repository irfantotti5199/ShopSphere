//
//  FavouritesView.swift
//  ShopSphere
//
//  Created by Irfan on 23/10/26.
//

import Foundation
import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject private var favouritesViewModel: FavouritesViewModel
    private var columns = [
        GridItem(.flexible(), spacing:12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
            Group {
                if favouritesViewModel.products.isEmpty {
                    ContentUnavailableView("No Favourites Yet", systemImage: "heart", description: Text("Tap the heart on a product to save it."))
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing:16) {
                            ForEach(favouritesViewModel.products) { product in
                                VStack(alignment: .trailing) {
                                    ProductCardView(product: product)
                                    
                                    Button {
                                        favouritesViewModel.removeFavourite(product)
                                    } label: {
                                        Label("Remove", systemImage: "heart.slash")
                                    }
                                    .font(.caption)
                                    
                                }
                            }
                    
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favourites")
        }
    }
}
