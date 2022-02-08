//
//  DBService.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import Foundation
import RealmSwift
import Realm

class DBService {
    public static let shared = DBService()
    
    lazy var helperQueue = DispatchQueue(label: "DBService", qos: .default)
    
    var realm: Realm {
        autoreleasepool{
            let realm = try! Realm()
            realm.autorefresh = false
            return realm
        }
    }
    private init(){}
    
    func writeDataToDB(objects: [Food]) -> Bool {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        var status: Bool = false
        do{
            try self.realm.write({ () -> () in
                self.realm.add(objects)
                status = true
            })
        }catch{
        }
        return status
    }
    
    func deleteFoodfromDB(food: Food) -> Bool{
        var deleted = false
            do{
                try self.realm.write({ () in
                    self.realm.delete(food)
                    deleted = true
                })
            }catch(let error){
                print("DB deleting error:- \(error.localizedDescription)")
            }
        
        return deleted
    }
    
    func getFoodDataFromDB() -> Results<Food>? {
        var results: Results<Food>?
        results = self.realm.objects(Food.self)
        return results
        }
    
}

