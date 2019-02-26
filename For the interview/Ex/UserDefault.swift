//
//  UserDefault.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    static let savedImg = "savedImg"
    
    
    func toSaveImg(photo:Photo){
        
        var savedImage = savedImg()
        let isExist = savedImage.contains(where: {$0.farm == photo.farm && $0.id == photo.id})
        
        if isExist {
            print("there is a object in the UserDefault already!")
            return
        }else{
            savedImage.insert(photo, at: 0)
        }
        
        do {
            
            let data =  try NSKeyedArchiver.archivedData(withRootObject: savedImage, requiringSecureCoding: true)
            
            setValue(data, forKey: UserDefaults.savedImg)
            synchronize()
            UIApplication.mainTabarController()?.viewControllers?[1].tabBarItem.badgeValue = "New"
        }catch let saveErr{
            print("saveErr",saveErr.localizedDescription)
            
        }
        
        
        
    }
    
    func savedImg()->[Photo]{
        
       
    
        do {
             guard let data = data(forKey: UserDefaults.savedImg) else { return [] }
            guard let savedImg = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self,Photo.self], from: data) as? [Photo] else { return [] }
            
            return savedImg
        }catch let savedImgErr {
            print("savedImgErr",savedImgErr.localizedDescription)
        }
        return []
    }
    
    
    
}
