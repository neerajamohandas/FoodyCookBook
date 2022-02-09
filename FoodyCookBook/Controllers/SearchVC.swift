//
//  SearchVC.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet var tableView_Search: UITableView!
    @IBOutlet var serachBar: UISearchBar!
    
    var results = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serachBar.delegate = self
        tableView_Search.delegate = self
        tableView_Search.dataSource = self
        serachBar.layer.borderColor = UIColor(named: "secondary_light")?.cgColor
        serachBar.layer.borderWidth = 1
        serachBar.layer.cornerRadius = 10
        serachBar.clipsToBounds = true
        
        tableView_Search.register(UINib(nibName: "FavTVCell", bundle: nil), forCellReuseIdentifier: "FavTVCell")
        tableView_Search.estimatedRowHeight = 700
    }

}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
     
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
        let api = Constants.API.searchFood.rawValue + text
        NetworkService.shared.getDataFromServer(url: api) { _data, _error in
            if _error == nil {
                if let data = _data {
                    let foods = data.value(forKey: "meals") as! NSArray
                    for i in 0...(foods.count - 1) {
                        let foodDict =  foods[i] as! NSDictionary
                        let foodItem = Food()
                        let name = foodDict.value(forKey: "strMeal") as? String ?? ""
                        foodItem.name = name
                        let id = foodDict.value(forKey: "idMeal") as? String ?? ""
                        foodItem.id = id
                        let recipe = foodDict.value(forKey: "strInstructions") as? String ?? ""
                        foodItem.instructions = recipe
                        let source = foodDict.value(forKey: "strSource") as? String ?? ""
                        foodItem.recipeLink = source
                        let video = foodDict.value(forKey: "strYoutube") as? String ?? ""
                        foodItem.recipeLink = video
                        let image = foodDict.value(forKey: "strMealThumb") as? String ?? ""
                        foodItem.recipeLink = image
                        self.results.append(foodItem)
                    }
                    print(self.results.count)
                    DispatchQueue.main.async {
                        self.tableView_Search.reloadData()
                    }
                }
            }else {
                print("No item found")
            }
            
            
        }
    }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let  cell = self.tableView_Search.dequeueReusableCell(withIdentifier: "FavTVCell", for: indexPath) as! FavTVCell
            let data = self.results[indexPath.row]
            cell.tableViewRef = tableView_Search
            cell.FoodItem = data
            cell.lbl_name.text = data.name
            cell.txtView_fullRecipe.text = data.instructions
            cell.imgView_fav.tintColor = UIColor.gray
            cell.txtView_recipeLink.text = "Watch video:-  " + data.videoLink
        return cell
    }
    
    
}
