//
//  CadUsersViewController.swift
//  finance
//
//  Created by Emerson  Rodrigues on 23/04/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit

import Firebase



class CadUsersViewController: UIViewController {

    @IBOutlet weak var lbNome: UITextField!
    @IBOutlet weak var lbEmail: UITextField!
    @IBOutlet weak var lbSenha: UITextField!
    
     var handle: AuthStateDidChangeListenerHandle?
     var ref: DatabaseReference!

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        ref = Database.database().reference()
       
    }
    
    func performUserChange(user: User?) {
        guard let user = user else {return}
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = lbNome.text
        changeRequest.commitChanges { (error) in
            if error != nil {
                print(error!)
            }
            self.ref.child("Usuario").child(user.uid).setValue(["email": self.lbEmail.text, "nome": self.lbNome.text])
            
            
            print("Indo para a próxima tela")
            
            
        }
    }

    
    func removeListener() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    
    
  
    

    @IBAction func btEnviar(_ sender: Any) {
        
        if (lbNome.text == ""){
            showToast(message: "Campo nome em branco")
            return
            
        }
        else if (lbEmail.text == ""){
            showToast(message: "Campo E-mail em branco")
            return
        }
        
        else if (lbSenha.text == ""){
            
            showToast(message: "Campo senha em branco")
            return
        }
        
        
        
        
        
        removeListener()
        Auth.auth().createUser(withEmail: lbEmail.text!, password: lbSenha.text!) { (result, error) in
            if error == nil {
                self.showToast(message: "Cadastro realizado")
                self.performUserChange(user: result?.user)
            } else {
                print(error!)
                self.showToast(message: "Erro no cadastro")
            }
        }
    }

}



