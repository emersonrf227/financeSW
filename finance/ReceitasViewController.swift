//
//  ReceitasViewController.swift
//  finance
//
//  Created by Emerson  Rodrigues on 01/05/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit
import Firebase

class ReceitasViewController: UITableViewController {
 
    var specialists: [Specialist] = []
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.observeAllValue()
        //self.observeChildAdded()
        
    }
    
    
    func observeAllValue() {
        let root = Database.database().reference()
        
        root.child("Lancamentos").observe(.value, with: { (snap) in
            // eseguito sulla main queue non appena finito il download
            
            // converto il contenuto dello snap nel dato che lo rappresenta, cioè un Dizionario con chiave String e valore Any
            guard let dictionary = snap.value as? [String : Any] else {
                return
            }
            
            print(dictionary.count)
            
            // creo un array temporaneo per la conversione del dizionario in Specialist
            var specialistArray: [Specialist] = []
            
            for element in dictionary { // itero il dizionario
                
                guard
                    let value = element.value as? [String : String], // converto il valore in un dizionario di String:String
                    let name = value["name"], // estrapolo il nome
                    let profession = value["profession"] // estrapolo la professione
                    else { return }
                
                let specialist = Specialist(name: name, profession: profession) // creo un oggetto Specialist
                specialistArray.append(specialist) // lo passo all'array temporaneo
                
            }
            
            self.specialists = specialistArray // assegno l'array temporaneo all'array utilizzato dalla tabella
          //  self.tableView.reloadData() // aggiorno la tabella
            
        })
    }
    
    
    func observeChildAdded() {
        let root = Database.database().reference()
        
        print("\n \n")
        
        root.child("specialists").observe(.childAdded, with: { (snap) in
            
            // estraggo i dati del professionista
            guard
                let dictionary = snap.value as? [String : String],
                let name = dictionary["name"],
                let profession = dictionary["profession"]
                else { return }
            
            let specialist = Specialist(name: name, profession: profession)
            
            self.specialists.append(specialist) // aggiunto l'elemento all'array della tabella prima dell'aggiornamento
            
            let count = self.specialists.count // prendo il numero di elementi in tabella
            let indexPath = IndexPath.init(row: count-1, section: 0) // genero l'indexPath in cui andrà il nuovo elemento
            
          
        })
    }
    
    
}

    


