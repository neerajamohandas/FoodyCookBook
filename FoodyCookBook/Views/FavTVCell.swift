//
//  FavTVCell.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import UIKit

class FavTVCell: UITableViewCell {
    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var txtView_recipeLink: UITextView!
    @IBOutlet var txtView_fullRecipe: UITextView!
    @IBOutlet var imgView_fav: UIImageView!
    
    @IBOutlet var view_Shadow: UIView!
    var tableViewRef: UITableView!
    var FoodItem = Food()
    var isFavouriteScreen = false
    override func awakeFromNib() {
        super.awakeFromNib()
        txtView_fullRecipe.sizeToFit()
        view_Shadow.layer.shadowColor = UIColor(named: "secondary_dark")?.cgColor
        view_Shadow.layer.shadowRadius = 4
        view_Shadow.layer.shadowOffset = CGSize(width: 0, height: 0)
        view_Shadow.layer.shadowOpacity = 0.5
        view_Shadow.layer.masksToBounds = false
        view_Shadow.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnFavTapped(_ sender: Any) {
        if imgView_fav.tintColor == UIColor.red {
            let status = DBService.shared.deleteFoodfromDB(food: self.FoodItem)
            if status { imgView_fav.tintColor = UIColor.gray }
            if isFavouriteScreen == true { tableViewRef.reloadData() }
        }else if imgView_fav.tintColor == UIColor.gray {
            let status = DBService.shared.writeDataToDB(objects: [self.FoodItem])
            if status { self.imgView_fav.tintColor = UIColor.red }
            if isFavouriteScreen == true { tableViewRef.reloadData() }
        }
    }
}
