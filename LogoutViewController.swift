//
//  LogoutViewController.swift
//  
//
//  Created by Emerson  Rodrigues on 01/05/19.
//

import UIKit
import Firebase
import FirebaseAuth

class LogoutViewController: UIViewController {
     let email = Auth.auth().currentUser?.email
  
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       FirebaseApp.configure()
       
    }
    
    func logout() {
        
   
        
        
    }
    
    
    
    
    
   
 
    @IBAction func btLogout(_ sender: Any) {
        
        logout()
    }
    
}
