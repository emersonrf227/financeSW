//
//  LoginViewController.swift
//  finance
//
//  Created by Emerson  Rodrigues on 23/04/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit
import Firebase



class LoginViewController: UIViewController {
    
    @IBOutlet weak var lbLogin: UITextField!
    @IBOutlet weak var lbSenha: UITextField!
    
        var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            print("Usuário logado:", user?.email)
            if let user = user {
                self.showMainScreen(user: user, animated: false)
            }
        })

    }
    
    func showMainScreen(user: User?, animated: Bool = true) {
        print("Indo para a próxima tela")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: ViewController.self)) else {return}
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func performUserChange(user: User?) {
        guard let user = user else {return}
        let changeRequest = user.createProfileChangeRequest()
       // changeRequest.displayName = tfName.text
        changeRequest.commitChanges { (error) in
            if error != nil {
                print(error!)
            }
            self.showMainScreen(user: user, animated: true)
        }
    }
    
    func removeListener() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }


    

    
    
    @IBAction func btLogin(_ sender: Any) {
        removeListener()
        Auth.auth().signIn(withEmail: lbLogin.text!, password: lbSenha.text!)             { (result, error) in
            if error == nil {
                self.performUserChange(user: result?.user)
            } else {
                print(error!)
            }
        }
    }

    

}
