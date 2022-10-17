//
//  HomeViewController.swift
//  foodly
//
//  Created by Sergei Kulagin on 19.10.2022.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var historyCollectionView: UICollectionView!

    var popularProducts: [ShortProduct] = [ShortProduct]()
    var historyProducts: [ShortProduct] = [ShortProduct]()
    
    
    var reloadNum: Int = 0 {
        didSet {
            if (reloadNum == 2){
                self.popularCollectionView.reloadData()
                self.historyCollectionView.reloadData()
                reloadNum = 0
            }
        }
    }
    
    let cellId = "cell"
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadPopularData()
        viewModel.loadHistoryData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailProduct") {
            let nav = segue.destination as! UINavigationController
            let tappedProduct = nav.topViewController as! ProductViewController
            tappedProduct.productCode = sender as! String
        }
    }
    
    func bindViewModel() {
        viewModel.popularProducts.bind { [weak self] popularProducts in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.popularProducts = popularProducts
                self.reloadNum += 1
            }
        }
        viewModel.historyProducts.bind { [weak self] historyProducts in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.historyProducts = historyProducts
                self.reloadNum += 1
            }
        }
        viewModel.isLoading.bind { [weak self] isLoading in
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
        searchBar.endEditing(true)
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)

        historyCollectionView.dataSource = self
        historyCollectionView.delegate = self
        historyCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.popularCollectionView){
            return popularProducts.count
        } else {
            return historyProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == popularCollectionView {
            let popularCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionViewCell
            for item in popularProducts {
                let markNum = item.rating
//                popularCell.productImage.image = viewModel.getImage(url: item.image)
                popularCell.barcode = "\(item.barcode)"
                popularCell.markNumber.text = String(markNum)
                popularCell.productLabel.text = item.name
                if (markNum <= 2.9){
                    popularCell.markView.backgroundColor = UIColor(named: "Chili300")
                } else if (markNum <= 4){
                    popularCell.markView.backgroundColor = UIColor(named: "Tiger")
                } else {
                    popularCell.markView.backgroundColor = UIColor(named: "Success")
                }
                popularCell.layer.borderWidth = 1
                popularCell.layer.cornerRadius = 10
                popularCell.layer.borderColor = UIColor(named: "Input")?.cgColor
            }
            
            
            
            
            return popularCell
        } else if collectionView == historyCollectionView{
            let historyCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionViewCell
            for item in historyProducts {
                let markNum = item.rating
//                historyCell.productImage.image = viewModel.getImage(url: item.image)
                historyCell.barcode = "\(item.barcode)"
                historyCell.markNumber.text = String(markNum)
                historyCell.productLabel.text = item.name
                if (markNum <= 2.9){
                    historyCell.markView.backgroundColor = UIColor(named: "Chili300")
                } else if (markNum <= 4){
                    historyCell.markView.backgroundColor = UIColor(named: "Tiger")
                } else {
                    historyCell.markView.backgroundColor = UIColor(named: "Success")
                }
                historyCell.layer.borderWidth = 1
                historyCell.layer.cornerRadius = 10
                historyCell.layer.borderColor = UIColor(named: "Input")?.cgColor
            }
            return historyCell
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductCollectionViewCell
        let data = cell.barcode
        self.performSegue(withIdentifier: "detailProduct", sender: data)
    }
}
