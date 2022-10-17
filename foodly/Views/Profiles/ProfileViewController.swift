//
//  ProfileViewController.swift
//  foodly
//
//  Created by Sergei Kulagin on 19.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    
    
    @IBOutlet weak var profileTableView: UITableView!
    let cellId = "profileCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.backgroundColor = UIColor.clear
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    
    }
    
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProfileTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.profileAvatar.image = UIImage(named: "men")
        cell.profileName.text = "Мефодий"
        cell.profileYears.text = "725 лет"

        return cell
    }
    
    
}
//extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCollectionViewCell
//        cell.profileAvatar.image = UIImage(named: "men")
//        cell.profileName.text = "Мефодий"
//        cell.profileYears.text = "725 лет"
//
//        return cell
//    }
//
//}
