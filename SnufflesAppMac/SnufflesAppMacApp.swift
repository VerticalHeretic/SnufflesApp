//
//  SnufflesAppMacApp.swift
//  SnufflesAppMac
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import SwiftUI

@main
struct SnufflesAppMacApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CharactersView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
