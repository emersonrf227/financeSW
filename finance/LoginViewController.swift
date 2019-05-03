//
//  LoginViewController.swift
//  finance
//
//  Created by Emerson  Rodrigues on 23/04/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit
import Firebase



class LoginViewController: UIViewController, UITextFieldDelegate{
    
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
 
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
    func showMainScreen(user: User?, animated: Bool = true) {
        print("Indo para a próxima tela")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: MainTabBarController.self)) else {
            print("Caiu no else")
            return}
        self.present(vc, animated: true, completion: nil)
          print("Desceu")
    }
    
    func performUserChange(user: User?) {
        guard let user = user else {return}
        let changeRequest = user.createProfileChangeRequest()
       // changeRequest.displayName = tfName.text
        changeRequest.commitChanges { (error) in
            if error != nil {
                print(error!)
            }
            self.showToast(message : "Login Realizado")
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
               
                print("Foi para o login")
                self.performUserChange(user: result?.user)
              
            } else {
                print(error!)
       
            }
        }
    }
    
 
  
   

}

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 145, y: self.view.frame.size.height-100, width: 290, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 7.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
