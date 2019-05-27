//
//  CardDespesasTableViewCell.swift
//  finance
//
//  Created by Henrique Pereira de Lima on 26/05/19.
//  Copyright © 2019 Emerson Rodrigues. All rights reserved.
//

import UIKit

class CardDespesasTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblDescricao: UILabel!
    @IBOutlet weak var lblValor: UILabel!
    @IBOutlet weak var lblPagamento: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
