//
//  SearchController.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit


class SearchController:UIViewController {
    
    
    class customTextField:UITextField {
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 8, dy: 8)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 8, dy: 8)
        }
    }
    
    
    let searchContentTextField:UITextField = {
        
        let tf = customTextField()
            tf.placeholder = "Search photos which you want!"
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        return tf
    }()
    
    
    let searchPerPageTextField:UITextField = {
        
        let tf = customTextField()
        tf.placeholder = "Enter numbers of presenting images"
        tf.keyboardType = .numberPad
         tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        return tf
    }()
    
    @objc fileprivate func handleEditingChanged(textField:UITextField){
      
        if textField == searchContentTextField {
            searchModel.content = textField.text
        }else{
            searchModel.perPage = textField.text
        }
       
    }
    
    let searchBtn:UIButton = {
        let bt = UIButton(type: .system)
            bt.setTitle("Search", for: .normal)
            bt.backgroundColor = UIColor.lightGray
            bt.isEnabled = false
        bt.setTitleColor(.white, for: .normal)
        bt.addTarget(self, action: #selector(searchPhoto), for: .touchUpInside)
        return bt
    }()
    
   @objc fileprivate func searchPhoto(){
        
        searchModel.performSearch { [unowned self](searchData) in
            
            let resultController = ResultController(collectionViewLayout:UICollectionViewFlowLayout())
            resultController.searchData = searchData
            self.navigationController?.pushViewController(resultController, animated: true)
        }

        
    }
    
    let searchModel = SearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayoutWithStackView()
        observerSearchModel()
        setupGesture()
        obseverKeyboard()
    
    }
    
    fileprivate func observerSearchModel(){
        searchModel.isFormValid.bind { [unowned self] (isForm) in
            
            guard let isForm = isForm else { return }
            if isForm {
                self.searchBtn.isEnabled = true
                self.searchBtn.backgroundColor = .blue
            }else{
                self.searchBtn.isEnabled = false
                self.searchBtn.backgroundColor = UIColor.lightGray
            }
        }
    }
    

    fileprivate func setupGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissal)))
    }
    
    @objc func handleDismissal(){
        view.endEditing(true)
    }
    
    fileprivate func obseverKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDis), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleDis(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.transform = .identity
        })
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//               NotificationCenter.default.removeObserver(self)
//    }
    
       lazy var overallStackView = UIStackView(arrangedSubviews:[ searchContentTextField,searchPerPageTextField,searchBtn])
    
    @objc func handleShowKeyboard(notification:Notification){
        
        if let info = notification.userInfo {
            
            guard let values = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
            
            let keyboardHeight = values.cgRectValue.height
            let bottomHeight = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
            let different = keyboardHeight - bottomHeight
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: -different - 8)
            })
        }
        
    }
    
    
    
    fileprivate func setupLayoutWithStackView(){
    
        overallStackView.axis = .vertical
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        
            overallStackView.distribution = .fillEqually
        
         view.addSubview(overallStackView)
          overallStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
           overallStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
            overallStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        
        
    }
    
}
