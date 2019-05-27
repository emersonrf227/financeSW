import UIKit
import Firebase



class ViewController: UIViewController {
    
    var specialists: [Specialist] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    var receitaSelecionada:Specialist?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.observeAllValue()
        specialists = []
        receitaSelecionada = nil
        self.observeChildAdded()
        
    }
    
    
//    func observeAllValue() {
//        let root = Database.database().reference()
//
//        root.child("Lancamentos").observe(.value, with: { (snap) in
//
//            guard let dictionary = snap.value as? [String : Any] else {
//                return
//            }
//
//            print(dictionary.count)
//
//
//            var specialistArray: [Specialist] = []
//
//            for element in dictionary {
//
//                guard
//                    let value = element.value as? [String : String],
//                    let descricao = value["descricao"],
//                    let valor = value["valor"]
//                    else { return }
//
//                let specialist = Specialist(descricao: descricao, valor: valor)
//                specialistArray.append(specialist)
//
//            }
//
//            self.specialists = specialistArray
//
//
//        })
//    }
    
    
    func observeChildAdded() {
        let root = Database.database().reference()
        
        print("\n \n")
//        let userID = Auth.auth().currentUser?.uid
//        root.child("Lancamentos").child(userID!).observe(.value) { (snapshot) in
//            let dictionary = snapshot.value as? [String:String]
//            print("Meu dado: \(dictionary)")
//        }
        root.child("Lancamentos").observe(.childAdded, with: { (snap) in


            guard
                let dictionary = snap.value as? [String : String],
                let descricao = dictionary["descricao"],
                let valor = dictionary["valor"],
                let id = dictionary["id"]
                else { return }

            let specialist = Specialist(descricao: descricao, valor: valor, id: id, formaPagamento: nil)

            print(specialist)

            self.specialists.append(specialist)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? CadReceitaViewController else {return}
        controller.receitaSelecionada = receitaSelecionada
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.specialists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let user = self.specialists[indexPath.row]
        cell.textLabel?.text = nil
        cell.detailTextLabel?.text = nil
        cell.textLabel?.text = user.descricao
        cell.detailTextLabel?.text = user.valor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        receitaSelecionada = specialists[indexPath.row]
        performSegue(withIdentifier: "receitasCadastro", sender: self)
    }
    
}

