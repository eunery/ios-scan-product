//
//  RatingDotTableViewCell.swift
//  foodly
//
//  Created by Sergei Kulagin on 21.12.2022.
//

import UIKit

class RatingDotTableViewCell: UITableViewCell {

    @IBOutlet weak var labelText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
