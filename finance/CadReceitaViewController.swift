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
    var receitaSelecionada:Specialist?
    
    
    @IBOutlet weak var lbDesc: UITextField!
    @IBOutlet weak var lbValor: UITextField!
    
    //Novo comentarioo
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cadastro de despesas"
        ref = Database.database().reference().child("Lancamentos")
        if let selecionado = receitaSelecionada {
            lbValor.text = selecionado.valor
            lbDesc.text = selecionado.descricao
        }
    }
    
    func estruturaDespesas(id:String,descricao:String,valor:String) -> [String:Any]{
        return ["id":id,"descricao": descricao, "valor": valor]
    }
    
    func salvarDados() {
        
        guard let desc = lbDesc.text, let valor = lbValor.text, let key = ref.childByAutoId().key else {
            return
        }
        let novaDespesa = estruturaDespesas(id: key, descricao: desc, valor: valor)
        ref.child(key).setValue(novaDespesa)
        
    }
    
    
    func atualizarDados(){
        
        guard let id = receitaSelecionada?.id, let desc = lbDesc.text, let valor = lbValor.text else {
            return
        }
        
        let receitaAtualizada = estruturaDespesas(id: id, descricao: desc, valor: valor)
        ref.child(id).setValue(receitaAtualizada)
    }
    
    func clearFields(){
        lbValor.text = ""
        lbDesc.text = ""
    }
  
    
    @IBAction func btCadastrar(_ sender: Any) {
        
        if receitaSelecionada == nil {
            salvarDados()
        } else {
            atualizarDados()
        }
        
        clearFields()
    }

}
