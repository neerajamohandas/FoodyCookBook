//
//  Food.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import Foundation
import RealmSwift
import Realm

class Food: Object  {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var instructions = ""
    @objc dynamic var thumbImage = ""
    @objc dynamic var videoLink = ""
    @objc dynamic var recipeLink = ""
}
