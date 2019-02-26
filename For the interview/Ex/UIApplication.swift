//
//  UIApplication.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static func mainTabarController() -> MainTabController? {
        
        return shared.keyWindow?.rootViewController as? MainTabController
    }
}
