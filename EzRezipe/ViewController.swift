//
//  ViewController.swift
//  EzRezipe
//
//  Created by Amrita Sodhi on 2023-03-30.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var cpasswordText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    var users: [NSManagedObject] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            ///Return will stop this program from continuing
            return
        }
        
        ///Get the reference to the persistent container's context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        ///Print the path where this is being saved
        print(appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url)
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }

    @IBAction func btnSignup(_ sender: UIButton)
    {
        let email = emailText.text!
        let password = passwordText.text!
        let cpassword = cpasswordText.text!
        
        if password == cpassword
        {
          //  let alert = UIAlertController(title: "Alert", message: "User Registered Succesfully.", preferredStyle: UIAlertController.Style.alert)
          //  alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
          //  self.present(alert, animated: true, completion: nil)
            self.save(email: email, password: password)
          
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "Password does not match", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
       
   
    
    }
    func save(email: String, password: String) {
        //MARK: - Save a name into Core Data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            ///Return if we cant access this
            return
        }
        
        ///Get reference to the container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        ///Find the entity called Person inside managedContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        ///Set the the name of the person to the name that was passed into the function
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        //MARK: - Commit our changes inside Core Data
        do {
            try managedContext.save() //save into core data
            users.append(user) //adding this to the array
            print("Data Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
}

}
