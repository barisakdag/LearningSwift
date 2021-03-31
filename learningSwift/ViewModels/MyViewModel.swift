//
//  JSONPlaceHolderViewModel.swift
//  learningSwift
//
//  Created by Baris Akdag on 2021-03-30.
//

import Foundation

public final class MyViewModel: NSObject {
    
   //MARK: Instance Propertiesss
    private var apiService : APIService!
    
    private(set) var jsonData : [MyModel] = [] {
        didSet {
            self.onDataChanged()
        }
    }
    
    var onDataChanged : (() -> ()) = {}
  
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    
    func callFuncToGetjsonData() {
        self.apiService.apiToGetData{(jsonData) in
            self.jsonData = jsonData
            print(self.jsonData)
        }

    }
    
    func getListOfData() -> Void{
        print(self.jsonData)
    }
        
   
}
