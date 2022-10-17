//
//  RatingTableViewCell.swift
//  foodly
//
//  Created by Sergei Kulagin on 21.12.2022.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var rigthLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
