//
//  ProductTableViewCell.swift
//  foodly
//
//  Created by Sergei Kulagin on 30.10.2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var tableName: UILabel!
    @IBOutlet weak var tableBackColor: UIView!
    @IBOutlet weak var tableDanger: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
