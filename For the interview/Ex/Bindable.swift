//
//  Bindable.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    var value:T?{
        didSet{
            
            observrer?(value)
        }
    }
    
    var observrer:((T?)->())?
    
    func bind(observer: @escaping (T?)->()){
        self.observrer = observer
    }
    
}
