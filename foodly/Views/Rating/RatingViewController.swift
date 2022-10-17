//
//  RatingViewController.swift
//  foodly
//
//  Created by Sergei Kulagin on 21.12.2022.
//

import UIKit

class RatingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var RatingTableView: UITableView!
    @IBOutlet weak var BenefitsTableView: UITableView!
    @IBOutlet weak var MinusesTableView: UITableView!
    @IBOutlet weak var rskrfLink: UIView!
    @IBOutlet weak var rskrfRating: UILabel!
    
    @IBOutlet weak var RatingTableHeight: NSLayoutConstraint!
    @IBOutlet weak var MinusesTableHeight: NSLayoutConstraint!
    @IBOutlet weak var BenefitsTableHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    
    var benefits: [Info] = [Info]()
    var minuses: [Info] = [Info]()
    
    var data: Rskrf? {
        didSet {
            for item in (data?.info)! {
                if (item.type == "good") {
                    benefits.append(item)
                } else if (item.type == "bad") {
                    minuses.append(item)
                }
            }
        }
    }
    let cellId = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        backgroundView.layer.cornerRadius = 25
        backgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        RatingTableView.dataSource = self
        RatingTableView.delegate = self
        RatingTableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        BenefitsTableView.dataSource = self
        BenefitsTableView.delegate = self
        BenefitsTableView.register(UINib(nibName: "RatingDotTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        MinusesTableView.dataSource = self
        MinusesTableView.delegate = self
        MinusesTableView.register(UINib(nibName: "RatingDotTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    override func viewWillLayoutSubviews() {
        self.RatingTableHeight.constant = self.RatingTableView.contentSize.height
        self.MinusesTableHeight.constant = self.MinusesTableView.contentSize.height
        self.BenefitsTableHeight.constant = self.BenefitsTableView.contentSize.height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == RatingTableView {
            return (data?.research?.count)!
        } else if (tableView == BenefitsTableView){
            var count = 0
            for item in (data?.info)! {
                if (item.type == "good") {
                    count += 1
                }
            }
            return count
        } else {
            var count = 0
            for item in (data?.info)! {
                if (item.type == "bad") {
                    count += 1
                }
            }
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == RatingTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RatingTableViewCell
            cell.leftLabel.text = data?.research?[indexPath.row].name
            cell.rigthLabel.text = "\(data?.research?[indexPath.row].value)/5"
            
            return cell
        } else if (tableView == BenefitsTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RatingDotTableViewCell
            cell.labelText.text = benefits[indexPath.row].value
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RatingDotTableViewCell
            cell.labelText.text = minuses[indexPath.row].value
            
            return cell
        }
        
        return UITableViewCell()
    }

}
