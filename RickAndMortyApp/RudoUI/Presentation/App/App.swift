//
//  RudoUIApp.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//  

import SwiftUI

@main
struct RudoUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
