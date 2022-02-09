//
//  FoodContentView.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import UIKit

class FoodContentView: UIView {
    
    //MARK: - Properties
    
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var lbl_foodName: UILabel!
    @IBOutlet var txtView_RecipeLink: UITextView!
    @IBOutlet var txtView_fullRecipe: UITextView!
    @IBOutlet var imgView_Fav: UIImageView!
    @IBOutlet var btn_Fav: UIButton!
    
    @IBOutlet var txtView_video: UITextView!
    var view_content: UIView!
    var FoodItem = Food()
    var btnFavTapped = false
    let userDefaults = UserDefaults.standard
    
    //MARK: - Initialisation and data loading
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        getDataFromAPI()
        self.view_content = self.loadViewFromNib_()
    }
    
    required public init?(coder aDecoder : NSCoder ) {
        super.init(coder: aDecoder)
        getDataFromAPI()
        self.view_content = self.loadViewFromNib_()
    }
    
    private func nibSetup() {
        
        DispatchQueue.main.async {
            self.view_content.frame = self.bounds
            self.view_content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view_content.translatesAutoresizingMaskIntoConstraints = true
            self.view_content.layer.shadowColor = UIColor(named: "secondary_dark")?.cgColor
            self.view_content.layer.shadowRadius = 4
            self.view_content.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.view_content.layer.shadowOpacity = 0.5
            self.view_content.layer.masksToBounds = false
            self.view_content.layer.cornerRadius = 10
            self.foodImage.layer.cornerRadius = 10
            self.lbl_foodName.text = self.FoodItem.name
            self.txtView_RecipeLink.text = "Recipe Source:-  " + self.FoodItem.recipeLink
            self.txtView_fullRecipe.text = self.FoodItem.instructions
            self.txtView_video.text = "Watch video:-  " + self.FoodItem.videoLink
            self.imgView_Fav.tintColor = UIColor.gray
            if self.FoodItem.thumbImage != "" {
                if let url = URL(string: self.FoodItem.thumbImage){
                    self.downloadImage(from: url)
                }
            }
            self.addSubview(self.view_content)
        }
    }
    
    private func loadViewFromNib_() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    //MARK: - IB Actions
    
    
    @IBAction func btnFav_Tapped(_ sender: Any) {
        if btnFavTapped == false {
            btnFavTapped = true
            let status = DBService.shared.writeDataToDB(objects: [self.FoodItem])
            if status { self.imgView_Fav.tintColor = UIColor.red }
        }
        else if btnFavTapped == true {
            btnFavTapped = false
            let status = DBService.shared.deleteFoodfromDB(food: self.FoodItem)
            if status { imgView_Fav.tintColor = UIColor.gray }
        }
    }
    
    
    
    //MARK: - methods
    
    func getDataFromAPI(){
        NetworkService.shared.getDataFromServer(url: Constants.API.randomFood.rawValue) { _data, _error in
            guard let dataDict = _data else { return }
            let foodItem = dataDict.value(forKey: "meals") as! NSArray
            let meal = foodItem.value(forKey: "strMeal") as! NSArray
            self.FoodItem.name = meal[0] as? String ?? ""
            let id = foodItem.value(forKey: "idMeal") as! NSArray
            self.FoodItem.id = id[0] as? String ?? ""
            let recipe = foodItem.value(forKey: "strInstructions") as! NSArray
            self.FoodItem.instructions = recipe[0] as? String ?? ""
            let source = foodItem.value(forKey: "strSource") as! NSArray
            self.FoodItem.recipeLink = source[0] as? String ?? ""
            let youtube = foodItem.value(forKey: "strYoutube") as! NSArray
            self.FoodItem.videoLink = youtube[0] as? String ?? ""
            let thumb = foodItem.value(forKey: "strMealThumb") as! NSArray
            self.FoodItem.thumbImage = thumb[0] as? String ?? ""
            self.nibSetup()
        }
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.foodImage.image = UIImage(data: data)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
