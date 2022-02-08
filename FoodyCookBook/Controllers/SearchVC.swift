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
    }

}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
        let api = Constants.API.searchFood.rawValue + text
        NetworkService.shared.getDataFromServer(url: api) { _data, _error in
            if let data = _data {
                print(data)
            }
        }
    }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
        let api = Constants.API.searchFood.rawValue + text
        NetworkService.shared.getDataFromServer(url: api) { _data, _error in
            if let data = _data {
                print(data)
            }
        }
    }
    }
}
