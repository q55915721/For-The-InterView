//
//  ResultController.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit

class ResultController:UICollectionViewController,UICollectionViewDelegateFlowLayout,ResultControllerCellDelegate {
   
    var savedImg = UserDefaults.standard.savedImg()
    
    func toCheckSavedImg(photo: Photo) {
   
        UserDefaults.standard.toSaveImg(photo: photo)
     
    }
    
    


    var searchData:SearchData?
    
    
    
    
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
        return searchData?.photos.photo.count ?? 0
    }
    
    fileprivate let cellid = "cellid"
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellid, for: indexPath) as! ResultControllerCell
        let photo = searchData?.photos.photo[indexPath.item]
        cell.photo = photo
        cell.delegate = self
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
