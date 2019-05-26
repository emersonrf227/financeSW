//
//  CadReceitaViewController.swift
//  finance
//
//  Created by Emerson  Rodrigues on 02/05/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit
import Firebase

class CadReceitaViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var lbDesc: UITextField!
    
   
    @IBOutlet weak var lbValor: UITextField!
    
    //Novo comentarioo
    
 
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cadastro de despesas"
        ref = Database.database().reference()
    }
    
    
  
    
    
    func salvarDados() {
        
        let desc = lbDesc.text
        let valor = lbValor.text
      
        self.ref.child("Lancamentos").childByAutoId().setValue(["descricao": desc, "valor": valor])
        
            
        }
    
    @IBAction func btCadastrar(_ sender: Any) {
        
        salvarDados()
    }

}
