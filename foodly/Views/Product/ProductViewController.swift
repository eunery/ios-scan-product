//
//  ProductViewController.swift
//  foodly
//
//  Created by Sergei Kulagin on 24.10.2022.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var descriptionContainer: UIView!
    @IBOutlet weak var tittleView: UILabel!
    @IBOutlet weak var isPershableView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productMark: UILabel!
    @IBOutlet weak var colorMark: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var allergyTable: UITableView!
    @IBOutlet weak var allergyTableHeight: NSLayoutConstraint!
    @IBOutlet weak var compatibilityTable: UITableView!
    @IBOutlet weak var compatibilityTableHeight: NSLayoutConstraint!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var rskrfRating: UILabel!
    
    @IBOutlet weak var isIntruder: UIView!
    @IBOutlet weak var rskrfIsHidden: UIView!
    
    @IBOutlet weak var linkToRatingRskrf: UIView!
    var products: [Product] = [Product]()
    var productCode: String = String()
    var productImageString: String = String()
    var supplements: [Supplements?] = [Supplements?]()
    var allergy: [Allergens?] = [Allergens?]()
    var reloadNum: Int = 0 {
        didSet {
            if (reloadNum == 2){
                self.allergyTable.reloadData()
                self.compatibilityTable.reloadData()
                reloadNum = 0
            }
        }
    }
    
    let cellId = "cell"
    
    var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        tittleView.text = productCode
        viewModel.loadData(codeNumber: productCode)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reloadNum = 0
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if rskrfIsHidden == touch.view {
                performSegue(withIdentifier: "showRskrf", sender: products[0].rskrf)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // showRskrf
        if (segue.identifier == "showRskrf") {
            let nav = segue.destination as! UINavigationController
            let rskrfData = nav.topViewController as! RatingViewController
            rskrfData.data = sender as! Rskrf?
        }
    }
    
    func bindViewModel() {
        viewModel.products.bind { [weak self] products in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.products = products
            }
            DispatchQueue.main.async {
                self.productName.text = products[0].name
            }
            DispatchQueue.main.async {
                self.productImageString = products[0].image
            }
            DispatchQueue.main.async {
                self.productDescription.text = products[0].composition
            }
            DispatchQueue.main.async {
                if products[0].supplements == nil {
                    return
                }
                self.supplements = products[0].supplements!
                self.reloadNum += 1
            }
            DispatchQueue.main.async {
                if products[0].allergens == nil {
                    return
                }
                self.allergy = products[0].allergens!
                self.reloadNum += 1
            }
            DispatchQueue.main.async {
                self.isPershableView.isHidden = !products[0].isPerishable
            }
            DispatchQueue.main.async {
                if (products[0].rskrf != nil) {
                    self.rskrfRating.text = "\(products[0].rskrf!.rating)"
                    if (products[0].rskrf?.rating == 0) {
                        self.rskrfIsHidden.backgroundColor = UIColor(named: "lightRed")
                        self.isIntruder.isHidden = !products[0].rskrf!.is_intruder
                    }
                } else {
                    self.rskrfIsHidden.isHidden = true
                }
            }
            
        }
        viewModel.productImage.bind { [weak self] productImage in
            guard let self = self, case let productImage = productImage else {
                return
            }
            DispatchQueue.main.async {
                self.productImage.image = productImage
            }
        }
        viewModel.isLoading.bind{ [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
             return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }
    
    func setupUI() {
        backgroundImage.layer.cornerRadius = 25
        backgroundImage.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        allergyTable.dataSource = self
        allergyTable.delegate = self
        allergyTable.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        compatibilityTable.dataSource = self
        compatibilityTable.delegate = self
        compatibilityTable.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        self.title = productCode
    }
    
    override func viewWillLayoutSubviews() {
        self.allergyTableHeight.constant = self.allergyTable.contentSize.height
        self.compatibilityTableHeight.constant = self.compatibilityTable.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.allergyTable){
            return self.allergy.count
        } else {
            return self.supplements.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == allergyTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.tableName.text = allergy[indexPath.row]?.ruName
            cell.tableDanger.text = "не знаю"
            let status = allergy[indexPath.row]?.status
            if (status == false){
                cell.tableBackColor.backgroundColor = UIColor(named: "Success")
                cell.tableDanger.text = "Нет"
            } else if (status == nil){
                cell.tableBackColor.backgroundColor = UIColor(named: "Tiger")
                cell.tableDanger.text = "Возможно"
            } else {
                cell.tableBackColor.backgroundColor = UIColor(named: "Chili300")
                cell.tableDanger.text = "Есть"
            }
            return cell
        } else if tableView === compatibilityTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.tableName.text = supplements[indexPath.row]?.name
            cell.tableDanger.text = "не знаю"
            let markNum = supplements[indexPath.row]?.data?.level
            if (markNum == 1){
                cell.tableBackColor.backgroundColor = UIColor(named: "Success")
                cell.tableDanger.text = "Безопасно"
            } else if (markNum == 2){
                cell.tableBackColor.backgroundColor = UIColor(named: "Tiger")
                cell.tableDanger.text = "Возможно"
            } else {
                cell.tableBackColor.backgroundColor = UIColor(named: "Chili300")
                cell.tableDanger.text = "Опасно"
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
}
