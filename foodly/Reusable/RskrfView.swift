//
//  RskrfView.swift
//  foodly
//
//  Created by Sergei Kulagin on 21.12.2022.
//

import UIKit

class RskrfView: UIView {

    @IBOutlet weak var actionButton: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var markText: UILabel!
    @IBOutlet weak var isIntruder: UIView!
    
    let nibName = "rskrfView"
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    fileprivate func setupView() {
            // do your setup here
    }

    class func instanceFromNib() -> RskrfView {
            let view = UINib(nibName: "rskrfView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RskrfView
            view.setupView()
            return view
     }

}
