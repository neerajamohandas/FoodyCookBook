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
    
    func getDataFromServer(url: String, completionHandler: @escaping (_ _data: NSDictionary?, _ _error: Error?) -> ()) {
        var result = NSDictionary()
        var urlComponents = URLComponents(string: url)
        urlComponents?.scheme = "https"
        
        
        guard let urlValue = urlComponents?.url else { return }
        var urlRequest = URLRequest(url: urlValue)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error == nil {
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                    result = json as! NSDictionary
                    completionHandler(result,nil)
                }catch{
                    print("Error while parsing data:- \(error.localizedDescription)")
                }
            }
            else {
                completionHandler(nil,error)
            }
        }
        task.resume()
       /*
        AF.request(urlRequest).response { response in
            
            switch response.result {
                
            case .success:
                guard let responseData = response.response else {return}
                guard let dataServer = response.data else {return}
                result = dataServer
            case .failure:
                print("Error when fetching data..")
            }
            
        }
        */
    }
}
