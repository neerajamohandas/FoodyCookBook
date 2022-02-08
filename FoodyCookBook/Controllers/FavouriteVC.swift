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
        favourites = DBService.shared.getFoodDataFromDB()!
    }
}

extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favourites")!
        return cell
    }
    
    
}
