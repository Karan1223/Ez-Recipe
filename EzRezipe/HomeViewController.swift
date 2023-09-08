//
//  HomeViewController.swift
//  EzRezipe
//
//  Created by Karan Punjabi on 2023-04-18.
//

import Foundation
import UIKit
import CoreData

class HomeViewController: UIViewController{
    @IBOutlet weak var imageV1: UIImageView!
    @IBOutlet weak var imagePizza: UIImageView!
    @IBOutlet weak var imageBurger: UIImageView!
    var name: String!
    @IBOutlet weak var nameLB: UILabel!
    var users: [NSManagedObject] = []
    var storedImageData: [UIImage] = []
    

    
//
        
    override func viewDidLoad()
    {
        
        
        
        
//        navBar.dataSource = self
        super.viewDidLoad()
   
        nameLB.text = name
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            ///Return will stop this program from continuing
            return
        }
        
        ///Get the reference to the persistent container's context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        ///Print the path where this is being saved
       // print(appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url)
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
       
        saveImage()
        
        fetchData()
        
        saveImagePizza()
        
        fetchDataPizza()
        
        saveImageBurger()
        
        fetchDataBurger()
       
    }
    
    

    func saveImage()
    {
        // Create a persistent container for your Core Data stack
        let container = NSPersistentContainer(name: "Login")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        }

        // Get a reference to the managed object context
        let context = container.viewContext

        // Create a new instance of your Core Data entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newImage = NSManagedObject(entity: entity!, insertInto: context) as! User
        
        // Load the image from the asset catalog
        let image = UIImage(named: "Bowl")

        // Convert the image into data
        let imageData = image?.pngData()

        // Set the binary data attribute to the image data
        newImage.coreImage1 = imageData

        // Save the context to persist the data
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Error saving image: \(error)")
        }

    }
    
    func saveImagePizza()
    {
        // Create a persistent container for your Core Data stack
        let container = NSPersistentContainer(name: "Login")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        }

        // Get a reference to the managed object context
        let context = container.viewContext

        // Create a new instance of your Core Data entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newImage = NSManagedObject(entity: entity!, insertInto: context) as! User
        
        // Load the image from the asset catalog
        let image = UIImage(named: "pizza")

        // Convert the image into data
        let imageData = image?.pngData()

        // Set the binary data attribute to the image data
        newImage.coreImagePizza = imageData

        // Save the context to persist the data
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Error saving image: \(error)")
        }

    }
    
    func saveImageBurger()
    {
        // Create a persistent container for your Core Data stack
        let container = NSPersistentContainer(name: "Login")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        }

        // Get a reference to the managed object context
        let context = container.viewContext

        // Create a new instance of your Core Data entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newImage = NSManagedObject(entity: entity!, insertInto: context) as! User
        
        // Load the image from the asset catalog
        let image = UIImage(named: "burger")

        // Convert the image into data
        let imageData = image?.pngData()

        // Set the binary data attribute to the image data
        newImage.coreImageBurger = imageData

        // Save the context to persist the data
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Error saving image: \(error)")
        }

    }
    
    func fetchData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            ///Return if we cant access this
            return
        }
        

        // Get a reference to the managed object context from the app delegate
        let managedContext = appDelegate.persistentContainer.viewContext
  
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "coreImage1 != nil")
        fetchRequest.returnsObjectsAsFaults = false

        do {
           let results = try managedContext.fetch(fetchRequest)
           if let object = results.first as? NSManagedObject {
               if let imageData = object.value(forKey: "coreImage1") as? Data {
                   let image = UIImage(data: imageData)
                   imageV1.image = image
               }
           }
        } catch let error as NSError {
           print("Fetch error: \(error) description: \(error.userInfo)")
        }

    }
    func fetchDataPizza()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            ///Return if we cant access this
            return
        }
        

        // Get a reference to the managed object context from the app delegate
        let managedContext = appDelegate.persistentContainer.viewContext
  
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "coreImagePizza != nil")
        fetchRequest.returnsObjectsAsFaults = false

        do {
           let results = try managedContext.fetch(fetchRequest)
           if let object = results.first as? NSManagedObject {
               if let imageData = object.value(forKey: "coreImagePizza") as? Data {
                   let image = UIImage(data: imageData)
                   imagePizza.image = image
               }
           }
        } catch let error as NSError {
           print("Fetch error: \(error) description: \(error.userInfo)")
        }

    }
    func fetchDataBurger()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            ///Return if we cant access this
            return
        }
        

        // Get a reference to the managed object context from the app delegate
        let managedContext = appDelegate.persistentContainer.viewContext
  
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "coreImageBurger != nil")
        fetchRequest.returnsObjectsAsFaults = false

        do {
           let results = try managedContext.fetch(fetchRequest)
           if let object = results.first as? NSManagedObject {
               if let imageData = object.value(forKey: "coreImageBurger") as? Data {
                   let image = UIImage(data: imageData)
                   imageBurger.image = image
               }
           }
        } catch let error as NSError {
           print("Fetch error: \(error) description: \(error.userInfo)")
        }

    }
}
