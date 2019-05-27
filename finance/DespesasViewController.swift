//
//  DespesasViewController.swift
//  finance
//
//  Created by Emerson  Rodrigues on 01/05/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit
import Firebase

class DespesasViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var specialistSelecionado:Specialist?
    
    var specialists: [Specialist] = [] {
        didSet{
            tableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        specialists = []
        specialistSelecionado = nil
        self.observeChildAdded()
        
    }
    
    func observeChildAdded() {
        let root = Database.database().reference()
        
        print("\n \n")
        
        root.child("Despesas").observe(.childAdded, with: { (snap) in
            
            
            guard
                let dictionary = snap.value as? [String : String],
                let descricao = dictionary["descricao"],
                let valor = dictionary["valor"],
                let id = dictionary["id"],
                let pagamento = dictionary["pagamento"]
                else { return }
            
            let specialist = Specialist(descricao: descricao, valor: valor, id: id, formaPagamento:pagamento)
            
            print(specialist)
            
            self.specialists.append(specialist)
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? CadDespViewController else {return}
        controller.specialistSelecionado = specialistSelecionado
        
    }
    
    
 
    
}

extension DespesasViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return specialists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardDespesas", for: indexPath) as? CardDespesasTableViewCell
        
        let despesa = self.specialists[indexPath.row]
        cell?.lblValor.text = nil
        cell?.lblDescricao.text = nil
        cell?.lblPagamento.text = nil
        cell?.lblValor.text = "Valor: \(despesa.valor)"
        cell?.lblDescricao.text = "Descrição: \(despesa.descricao)"
        let pagamento = despesa.formaPagamento ?? ""
        cell?.lblPagamento.text = "Pagamento: \(pagamento)"
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        specialistSelecionado = specialists[indexPath.row]
        self.performSegue(withIdentifier: "cadastroDespesas", sender: self)
    }
    
}
