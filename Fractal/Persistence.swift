//
//  Persistence.swift
//  Fractal
//
//  Created by Ryan OToole on 9/11/24.
//

import CoreData

enum PersistenceError: Error {
    case failedToLoadPersistentStores(Error)
    case failedToSaveContext(Error)
}

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try result.save()
        } catch {
            print("Error creating preview: \(error.localizedDescription)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Fractal")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                // Instead of fatalError, we'll print the error and continue
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save() throws {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw PersistenceError.failedToSaveContext(error)
            }
        }
    }
}
