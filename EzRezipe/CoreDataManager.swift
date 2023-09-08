import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Login")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error.localizedDescription)")
            }
        }
        return container
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // Optional: You can also create a private queue context for performing background tasks
    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
}
