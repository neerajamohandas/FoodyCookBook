//
//  HomeVC.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var view_FoodContentView: FoodContentView!
    var FoodItem = Food()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
