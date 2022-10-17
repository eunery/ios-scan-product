//
//  ProfileTableViewCell.swift
//  foodly
//
//  Created by Sergei Kulagin on 23.11.2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
   
    @IBOutlet weak var profileEdit: UIButton!
    @IBOutlet weak var profileYears: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
