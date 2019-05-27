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
    var specialistSelecionado:Specialist? = nil

    @IBOutlet weak var txtDescricao: UITextField!
    @IBOutlet weak var txtValor: UITextField!
    @IBOutlet weak var txtPagamento: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         ref = Database.database().reference().child("Despesas")
        
        if let selecianado  = specialistSelecionado {
            txtValor.text = selecianado.valor
            txtDescricao.text = selecianado.descricao
            txtPagamento.text = selecianado.formaPagamento ?? ""
        }
    }
    
    func estruturaDespesas(id:String,descricao:String,valor:String,formaPagamento:String) -> [String:Any]{
        return ["id":id,"descricao": descricao, "valor": valor,"pagamento":formaPagamento]
    }
    
    func salvarDados() {
        
        guard let desc = txtDescricao.text, let valor = txtValor.text, let key = ref.childByAutoId().key, let pagamento = txtPagamento.text else {
            return
        }
        let novaDespesa = estruturaDespesas(id: key, descricao: desc, valor: valor, formaPagamento: pagamento)
        ref.child(key).setValue(novaDespesa)
        
    }
    
    
    func atualizarDados(){
        guard let id = specialistSelecionado?.id, let desc = txtDescricao.text, let valor = txtValor.text, let pagamento = txtPagamento.text else {
            return
        }
        let despesaAtualizada = estruturaDespesas(id: id, descricao: desc, valor: valor, formaPagamento: pagamento)
        ref.child(id).setValue(despesaAtualizada)
    }
    
    func clearFields(){
        txtValor.text = ""
        txtDescricao.text = ""
        txtPagamento.text = ""
    }
    
    @IBAction func btCadastrar(_ sender: Any) {
        if specialistSelecionado == nil {
            salvarDados()
        } else {
            atualizarDados()
        }
        
        clearFields()
    }
    

   

}
