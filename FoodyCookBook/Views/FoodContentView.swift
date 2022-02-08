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
    @IBOutlet var btn_watchVideo: UIButton!
    @IBOutlet var txtView_fullRecipe: UITextView!
    @IBOutlet var imgView_Fav: UIImageView!
    @IBOutlet var btn_Fav: UIButton!
    
    var view_content: UIView!
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required public init?(coder aDecoder : NSCoder ) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        view_content = loadViewFromNib_()
        view_content.frame = bounds
        view_content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view_content.translatesAutoresizingMaskIntoConstraints = true
        view_content.layer.shadowColor = UIColor(named: "secondary_dark")?.cgColor
        view_content.layer.shadowRadius = 4
        view_content.layer.shadowOffset = CGSize(width: 0, height: 0)
        view_content.layer.shadowOpacity = 0.5
        view_content.layer.masksToBounds = false
        view_content.layer.cornerRadius = 10
        getDataFromAPI()
        addSubview(view_content)
    }
    
    private func loadViewFromNib_() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }

    @IBAction func btnFav_Tapped(_ sender: Any) {
    }
    @IBAction func btnWatchVideo_Tapped(_ sender: Any) {
    }
    
    func getDataFromAPI(){
        let data = NetworkService.shared.getDataFromServer(url: Constants.API.randomFood.rawValue)
        let food = Food()
        //food.name = data.value(forKey: "strMeal") as! String
    }
}
