//
//  FractalApp.swift
//  Fractal
//
//  Created by Ryan OToole on 9/11/24.
//

import SwiftUI
import CoreData

@main
struct FractalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                    do {
                        try persistenceController.save()
                    } catch {
                        print("Failed to save context on app termination: \(error.localizedDescription)")
                    }
                }
        }
    }
}
