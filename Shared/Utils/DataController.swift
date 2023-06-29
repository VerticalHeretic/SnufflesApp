//
//  DataController.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 29/06/2023.
//

import Foundation
import CoreData

final class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "SnuffleApp")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                Log.coreData.error("Core Data failed to load: \(error)")
            }
        }
    }
}
