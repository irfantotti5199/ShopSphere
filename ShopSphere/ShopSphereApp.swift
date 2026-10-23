//
//  ShopSphereApp.swift
//  ShopSphere
//
//  Created by Irfan on 22/10/26.
//

import SwiftUI
import CoreData

@main
struct ShopSphereApp: App {
    
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var favouritesViewModel = FavouritesViewModel()
    
    private let persistenceController = PersistenceViewController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ProductListView()
                    .tabItem {
                        Label("Shop", systemImage: "storefront")
                    }
                
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                    }
                
                FavouritesView()
                    .tabItem {
                        Label("Favourites", systemImage: "heart")
                    }
            }
            .environmentObject(cartViewModel)
            .environmentObject(favouritesViewModel)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
                
        }
    }
}
