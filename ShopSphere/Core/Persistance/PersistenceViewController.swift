//
//  PersistenceViewController.swift
//  ShopSphere
//
//  Created by Irfan on 23/10/26.
//

import Foundation
import CoreData

struct PersistenceViewController {
    static let shared = PersistenceViewController()
    
    let container: NSPersistentContainer
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ShopSphere")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _,error in
            if let error = error as? NSError {
                fatalError(
                    "Failed to load Cora Data Store \(error), \(error.userInfo)"
                )
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

