//
//  ProductCardView.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import SwiftUI
 
struct ProductCardView: View {
    
    let product: Product
    var body: some View {
        VStack(alignment: .leading, spacing:8) {
            AsyncImage(url: product.thumbnail) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.8)
                    ProgressView()
                }
            }
            .frame(height:140)
            .frame(maxWidth: .infinity)
            .clipped()
            
            Text(product.title)
                .font(.headline)
                .lineLimit(2)
            
            Label(
                String(format: "%.1f", product.rating),systemImage: "star.fill")
            .font(.caption)
            .foregroundStyle(.orange)
            
            Text(product.price, format: .currency(code: "USD"))
                .font(.title3.bold())
                   
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background, in: RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray.opacity(0.2),lineWidth: 1)
        }
    }
}

