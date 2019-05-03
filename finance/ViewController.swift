import UIKit
import Firebase



class ViewController: UIViewController {
    
    var specialists: [Specialist] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.observeAllValue()
        self.observeChildAdded()
        
    }
    
    
    func observeAllValue() {
        let root = Database.database().reference()
        
        root.child("Lancamentos").observe(.value, with: { (snap) in
           
           
            guard let dictionary = snap.value as? [String : Any] else {
                return
            }
            
            print(dictionary.count)
            
            
            var specialistArray: [Specialist] = []
            
            for element in dictionary {
                
                guard
                    let value = element.value as? [String : String],
                    let descricao = value["descricao"],
                    let valor = value["valor"]
                    else { return }
                
                let specialist = Specialist(descricao: descricao, valor: valor)
                specialistArray.append(specialist)
                
            }
            
            self.specialists = specialistArray
            self.tableView.reloadData()
            
        })
    }
    
    
    func observeChildAdded() {
        let root = Database.database().reference()
        
        print("\n \n")
        
        root.child("Lancamentos").observe(.childAdded, with: { (snap) in
            
            
            guard
                let dictionary = snap.value as? [String : String],
                let descricao = dictionary["descricao"],
                let valor = dictionary["valor"]
                else { return }
            
            let specialist = Specialist(descricao: descricao, valor: valor)
            
            print(specialist)
            
            self.specialists.append(specialist)
            
            let count = self.specialists.count
            let indexPath = IndexPath.init(row: count-1, section: 0) //
            
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPath], with: .left) //
            self.tableView.endUpdates()
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
        
        cell.textLabel?.text = user.descricao
        cell.detailTextLabel?.text = user.valor
        
        return cell
    }
    
}

