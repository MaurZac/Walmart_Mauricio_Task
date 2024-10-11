//
//  CoreDataManager.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 11/10/24.
//
import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductList")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error al cargar core data: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error al guardar core data: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
