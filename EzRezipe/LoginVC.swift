//
//  LoginVC.swift
//  EzRezipe
//
//  Created by Karan Punjabi on 2023-04-17.
//

import Foundation
import UIKit
import CoreData

class LoginVC: UIViewController
{
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailTF: UITextField!

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
    
    

    @IBAction func btnLogin(_ sender: UIButton)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        ///Return if we cant access this
        return
    }
    
    ///Get reference to the container
    let managedContext = appDelegate.persistentContainer.viewContext
    
    
        let email = emailTF.text!
        let password = password.text!
        let context = CoreDataManager.shared.managedObjectContext
        
        //let destinationVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
       

        //destinationVC.name = emailTF.text
//        print("TextBox\(emailTF.text)")
//        print("DVC\(destinationVC.name)")
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)

            do {
                let users = try context.fetch(fetchRequest)
                if let user = users.first
                {
        
                
                } else {
                    let alert = UIAlertController(title: "Incorrect Credentials", message: "Incorrect username or password.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
               
                }
            } catch {
                print("Failed to login: \(error.localizedDescription)")
              
            }
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "Segue1" {
                
                let destinationVC = segue.destination as! HomeViewController
     
                destinationVC.name = emailTF.text
            }
        }
//    func handleSuccessfulLogin() {
//        let homeVC = HomeViewController() // Instantiate the home view controller
//        self.navigationController?.pushViewController(homeVC, animated: true)
//            // Display successful login alert
//            let alertController = UIAlertController(title: "Login Successful", message: "You are now logged in!", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
//                // Dismiss the alert before navigating to home page
//                alertController.dismiss(animated: true, completion: {
//                    // Navigate to home page
//                    let homeVC = HomeViewController() // Instantiate the home view controller
//                    self.navigationController?.pushViewController(homeVC, animated: true) // Push to home view controller
//                })
//            })
//            alertController.addAction(okAction)
//            present(alertController, animated: true, completion: nil)
     //   }
       

    }
    



