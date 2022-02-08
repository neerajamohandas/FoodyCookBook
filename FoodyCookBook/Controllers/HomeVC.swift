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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func getDataFromAPI(completion: @escaping () -> ()){
        
        NetworkService.shared.getDataFromServer(url: Constants.API.randomFood.rawValue) { _data, _error in
            guard let dataDict = _data else { return }
            let foodItem = dataDict.value(forKey: "meals") as! NSArray
            let meal = foodItem.value(forKey: "strMeal") as! NSArray
            self.FoodItem.name = meal[0] as! String
            let id = foodItem.value(forKey: "idMeal") as! NSArray
            self.FoodItem.id = id[0] as! String
            let recipe = foodItem.value(forKey: "strInstructions") as! NSArray
            self.FoodItem.instructions = recipe[0] as! String
            let source = foodItem.value(forKey: "strSource") as! NSArray
            self.FoodItem.recipeLink = source[0] as! String
            let youtube = foodItem.value(forKey: "strYoutube") as! NSArray
            self.FoodItem.videoLink = youtube[0] as! String
            let thumb = foodItem.value(forKey: "strMealThumb") as! NSArray
            self.FoodItem.thumbImage = thumb[0] as! String
        }
    }
}
