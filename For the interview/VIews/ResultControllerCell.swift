//
//  ResultControllerCell.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit
import SDWebImage

protocol ResultControllerCellDelegate {
    func toCheckSavedImg(photo:Photo)
}

class ResultControllerCell:UICollectionViewCell {
    
    
    var delegate:ResultControllerCellDelegate?
    var photo:Photo!{
        didSet{
            guard let url =  URL(string: "https://farm\(photo.farm ?? 0).staticflickr.com/\(photo.server ?? "")/\(photo.id ?? "")_\(photo.secret ?? "")_m.jpg") else {return}
            
           imageView.sd_setImage(with: url)
            titleLable.text = photo.title
            checkImgStatus()
           
        }
    }
    
    let imageView:UIImageView = {
       let iv = UIImageView()
            iv.backgroundColor = .lightGray
      
        return iv
    }()
    
    let titleLable:UILabel = {
        let lb = UILabel()
            lb.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            lb.text = "Title"
            lb.textAlignment = .center
        return lb
    }()
    
   lazy var likeBtn:UIButton = {
        let bt = UIButton(type: .system)
            bt.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            bt.translatesAutoresizingMaskIntoConstraints = false
            bt.imageView?.clipsToBounds = true
        bt.addTarget(self, action: #selector(handleSaveImage), for: .touchUpInside)
        return bt
    }()
    
   @objc fileprivate func handleSaveImage(){
    
    delegate?.toCheckSavedImg(photo: self.photo)
    checkImgStatus()
     likeBtn.setImage(#imageLiteral(resourceName: "starBlack").withRenderingMode(.alwaysOriginal), for: .normal)
    }

    

    var savedImg = UserDefaults.standard.savedImg()
    fileprivate func checkImgStatus(){
        
        let isExist = savedImg.contains(where: {$0.farm == self.photo.farm && $0.id == self.photo.id})
        
        if isExist {
            likeBtn.setImage(#imageLiteral(resourceName: "starBlack").withRenderingMode(.alwaysOriginal), for: .normal)
            print("this image is existing...")
        }else{
            
            likeBtn.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
       
        
    }
    
    fileprivate func setupUI(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let stackView = UIStackView(arrangedSubviews: [imageView,titleLable])
            stackView.axis = .vertical
        
        addSubview(stackView)
        addSubview(likeBtn)
        stackView.fillSuperview()

        likeBtn.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor ,padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) ,size: CGSize(width: 24, height:24))
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
