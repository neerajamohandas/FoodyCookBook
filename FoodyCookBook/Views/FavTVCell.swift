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
    
    var tableViewRef: UITableView!
    var FoodItem = Food()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnFavTapped(_ sender: Any) {
        if imgView_fav.tintColor == UIColor.red {
            let status = DBService.shared.deleteFoodfromDB(food: self.FoodItem)
            if status { imgView_fav.tintColor = UIColor.gray }
            tableViewRef.reloadData()
        }else if imgView_fav.tintColor == UIColor.gray {
            let status = DBService.shared.writeDataToDB(objects: [self.FoodItem])
            if status { self.imgView_fav.tintColor = UIColor.red }
            tableViewRef.reloadData()
        }
    }
}
