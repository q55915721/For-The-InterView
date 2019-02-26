//
//  searchModel.swift
//  For the interview
//
//  Created by 洪森達 on 2019/2/26.
//  Copyright © 2019 洪森達. All rights reserved.
//

import Foundation


class SearchModel {
    
    var isFormValid = Bindable<Bool>()
    
    var content: String? { didSet { checkFormValidity() } }
    var perPage: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isValid = content?.isEmpty == false && perPage?.isEmpty == false
        isFormValid.value = isValid
   }
    
    func performSearch(completion:@escaping(_ searchData:SearchData)->()){
            guard let content = content , let perPage = perPage else {return}
        
        APIService.shared.searchPhotos(searchText: content, perPage: perPage) { (SearchData) in
        
            completion(SearchData)
        }
        
    }

}
