//
//  CoreDataManager.swift
//  VPD
//
//  Created by durodola on 27/09/2024.
//

import CoreData
import UIKit

class CoreDataStack {
    static let shared = CoreDataStack()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "RepositoryModel")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

class RepositoryManager {
    let context = CoreDataStack.shared.context
    
    func saveRepositories(_ repositories: [RepositoryResponseData]) {
        deleteAllRepositories()
        
        for repoData in repositories {
            let repository = CoreDataRepository(context: context)
            repository.id = Int64(repoData.id)
            repository.name = repoData.name
            repository.fullName = repoData.fullName
            repository.url = repoData.url
            repository.repoDescription = repoData.description
            repository.ownerAvatarURL = repoData.owner.avatarURL
            repository.type = repoData.owner.type
            do {
                try context.save()
            } catch {
                print("Error saving repository: \(error)")
            }
        }
    }
    
    func fetchRepositories() -> [CoreDataRepository]? {
        let request: NSFetchRequest<CoreDataRepository> = CoreDataRepository.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching repositories: \(error)")
            return nil
        }
    }
    
    func deleteAllRepositories() {
        let request: NSFetchRequest<NSFetchRequestResult> = CoreDataRepository.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error deleting repositories: \(error)")
        }
    }
}
