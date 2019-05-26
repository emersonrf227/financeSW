import UIKit
import Firebase



class ViewController: UIViewController {
    
    var specialists: [Specialist] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.observeAllValue()
        specialists = []
        self.observeChildAdded()
        
    }
    
    
    func observeAllValue() {
        let root = Database.database().reference()
        
        root.child("Lancamentos").observe(.value, with: { (snap) in
           
           let dictionary = snap.value as? NSDictionary
//            guard let dictionary = snap.value as? [String : Any] else {
//                return
//            }
            
//            print(dictionary.count)
            
            
            var specialistArray: [Specialist] = []
            
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
            
            self.specialists = specialistArray
            
            
        })
    }
    
    
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
                let valor = dictionary["valor"]
                else { return }

            let teste = dictionary["valor"]

            let specialist = Specialist(descricao: descricao, valor: valor)

            print(specialist)

            self.specialists.append(specialist)

//            let count = self.specialists.count
//            let indexPath = IndexPath.init(row: count-1, section: 0) //
//
//            self.tableView.beginUpdates()
//            self.tableView.insertRows(at: [indexPath], with: .left) //
//            self.tableView.endUpdates()
        })
    }
    
    
}

extension ViewController: UITableViewDataSource {
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
    
}

