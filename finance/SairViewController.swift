//
//  SairViewController.swift
//  finance
//
//  Created by Emerson  Rodrigues on 01/05/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit
import Firebase

class SairViewController: UIViewController {
    
    let firebaseauth = Auth.auth()
     

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    
    func showMainScreen() {
        print("Indo para a próxima tela")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: LoginViewController.self)) else {
            print("Caiu no else")
            return}
        self.present(vc, animated: true, completion: nil)
        print("Desceu")
        logout()
    }
    
    func logout(){
        
         try! Auth.auth().signOut()
    }
    
    @IBAction func btSair(_ sender: Any) {
        
    showMainScreen()
   
}


}
