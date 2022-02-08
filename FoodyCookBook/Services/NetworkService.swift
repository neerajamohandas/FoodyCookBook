//
//  NetworkService.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    let session = URLSession.shared
    
    func getDataFromServer(url: String) -> NSDictionary {
        var result = NSDictionary()
        guard let urlValue = URL(string: url) else { return NSDictionary.init() }
        let task = session.dataTask(with: urlValue) { data, response, error in
            if error == nil {
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                    result = json as! NSDictionary
                }catch{
                    print("Error while parsing data:- \(error.localizedDescription)")
                }
            }
            else {
                
            }
        }
        task.resume()
        return result
    }
}
