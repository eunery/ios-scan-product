//
//  ProductCollectionViewCell.swift
//  foodly
//
//  Created by Sergei Kulagin on 23.10.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var markView: UIView!
    @IBOutlet weak var markNumber: UILabel!
    
    var barcode: String = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
