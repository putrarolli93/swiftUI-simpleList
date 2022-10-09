//
//  listwithsearchApp.swift
//  listwithsearch
//
//  Created by putra rolli on 09/10/22.
//

import SwiftUI

@main
struct listwithsearchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
