//
//  CoreDataManager.swift
//  bestsourceofmovies
//
//  Created by Vadim on 01/05/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataProtocol {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext() throws
}

final class CoreDataManager: CoreDataProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Movie")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() throws {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error {
            fatalError("Unresolved error \(error.localizedDescription)")
        }
    }
    
    public func fetchNews() -> [MoviePreview] {
        let request: NSFetchRequest<MoviePreview> = MoviePreview.fetchRequest()
        var newsArray = [MoviePreview]()
        
        do {
            let movie = try context.fetch(request)
            for item in movie {
                newsArray.append(item)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return newsArray
    }
    
    public func save(_ movie: [MoviePreviewStruct], removePrevious: Bool) {
        print("calling save func..")
        if (removePrevious) {
            print("removing prev data..")
            removeData()
            print("prev data removed")
        }
        
        print("entering movies loop..")
        for item in movie {
            print("initing MoviePreview model..")
            MoviePreview.init(with: item, in: context)
            print("inited MoviePreview model..")
            do {
                print("saving data..")
                try saveContext()
                print("saved")
            } catch let error as NSError {
                print("an error occuried during save")
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    private func removeData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviePreview")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
