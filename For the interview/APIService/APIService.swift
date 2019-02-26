//
//  APISevice.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import Foundation
import Alamofire

//fc3b0d28033941f3b31f6eece7ff450b
//https://api.flickr.com/services
//https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

//https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=fc3b0d28033941f3b31f6eece7ff450b&text=apple&per_page=40&format=json

class APIService {
    
    static let shared = APIService()
    let basicUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search"
    let api_key = "fc3b0d28033941f3b31f6eece7ff450b"
    func searchPhotos(searchText:String,perPage:String ,completion:@escaping (_ searchdata:SearchData) ->()){
        

        let parameters:Parameters = ["api_key":api_key,"text":searchText,"per_page":perPage,"format":"json","nojsoncallback":1]
        
        Alamofire.request(basicUrl, method: .get, parameters: parameters, encoding:  URLEncoding.default, headers: nil).response { (resdata) in
            
            
            if let err = resdata.error {
                print(err.localizedDescription)
                return
            }
            
            guard let data = resdata.data else { return }
           
            do{
                
                let jsonData = try JSONDecoder().decode(SearchData.self, from: data)
                completion(jsonData)
                
            }catch let jsonErr {
                print("jsonErr",jsonErr.localizedDescription)
            }
        }
        
        
    }

}
