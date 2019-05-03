//
//  CadDespViewController.swift
//  finance
//
//  Created by Emerson  Rodrigues on 02/05/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit
import Firebase

class CadDespViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!


    override func viewDidLoad() {
        super.viewDidLoad()

         ref = Database.database().reference()
    }
    

   

}
