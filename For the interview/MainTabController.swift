//
//  ViewController.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        setViewControllers()
        
    }
    
    fileprivate func setViewControllers(){
        
        let favo = FavoriteController(collectionViewLayout:UICollectionViewFlowLayout())
        viewControllers = [
            generateNavController(root: SearchController(), title: "Search Photos"),
            generateNavController(root: favo, title: "Favorites")
        
        ]
    }
    
    
    fileprivate func generateNavController(root:UIViewController ,title:String) -> UIViewController {
        
            root.navigationItem.title = title
        let nv = UINavigationController(rootViewController: root)
            nv.tabBarItem.title = title
            nv.tabBarItem.image = #imageLiteral(resourceName: "heart")
        return nv
    
    }


}

