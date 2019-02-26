//
//  Photo.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import Foundation

class Photo: NSObject,NSCoding,Codable,NSSecureCoding {
    static var supportsSecureCoding: Bool{
        return true
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(farm, forKey: "farm")
        aCoder.encode(secret, forKey: "secret")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(server, forKey: "server")
        aCoder.encode(title, forKey: "title")
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        farm = aDecoder.decodeObject(forKey: "farm") as? Int
        secret = aDecoder.decodeObject(forKey: "secret") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        server = aDecoder.decodeObject(forKey: "server") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
       
    }
    
    let farm: Int?
    let secret: String?
    let id: String?
    let server: String?
    let title: String?
   
}
struct PhotoData: Decodable {
    let photo: [Photo]
    
}

struct SearchData: Decodable {
    let photos: PhotoData
    
}


