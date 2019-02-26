//
//  FavoriteController.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit


import UIKit

class FavoriteController:UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    var photos = UserDefaults.standard.savedImg()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        photos = UserDefaults.standard.savedImg()
        UIApplication.mainTabarController()?.viewControllers?[1].tabBarItem.badgeValue = nil
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = "Search Results"
        
        setupCell()
      
    }
    
    fileprivate func setupCell(){
        
        collectionView.register(ResultControllerCell.self, forCellWithReuseIdentifier: cellid)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    fileprivate let cellid = "cellid"
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellid, for: indexPath) as! ResultControllerCell
        let photo = photos[indexPath.item]
        cell.photo = photo
        cell.likeBtn.isHidden = true
        return cell
    }
    let padding:CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - padding * 3) / 2
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    
}

