//
//  FavouriteVC.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import UIKit
import Realm
import RxRealm
import RealmSwift

class FavouriteVC: UIViewController {

    @IBOutlet var tableView_Fav: UITableView!
    
    var favourites: Results<Food>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView_Fav.delegate = self
        tableView_Fav.dataSource = self
        //favourites = DBService.shared.getFoodDataFromDB()!
        tableView_Fav.estimatedRowHeight = 750
        tableView_Fav.register(UINib(nibName: "FavTVCell", bundle: nil), forCellReuseIdentifier: "FavTVCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        favourites = DBService.shared.getFoodDataFromDB()!
        tableView_Fav.reloadData()
    }
}

extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavTVCell", for: indexPath) as! FavTVCell
        cell.tableViewRef = tableView
        let food = favourites?[indexPath.row]
        cell.FoodItem = food!
        cell.lbl_name.text = food?.name
        cell.txtView_recipeLink.text = "Watch video:- " + food!.videoLink
        cell.txtView_fullRecipe.text = food?.instructions
        cell.imgView_fav.tintColor = UIColor.red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
