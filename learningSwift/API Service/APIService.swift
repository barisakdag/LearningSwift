//
//  APIService.swift
//  learningSwift
//
//  Created by Baris Akdag on 2021-03-31.
//

import Foundation

protocol APIService {
    func apiToGetData(completion: @escaping ([MyModel]) -> ()) -> ()
}

class ApiServiceJSON: APIService {
    private let sourcesURL = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    func apiToGetData(completion: @escaping ([MyModel]) -> ()) {
        URLSession.shared.dataTask(with: sourcesURL) { data, _, _ in
            if let data = data {
                let jsonDecoder = JSONDecoder()

                let decoder = try! jsonDecoder.decode([MyModel].self, from: data)

                completion(decoder)
            }
        }.resume()
    }
}

class TestApiService: APIService {
    let testData: [MyModel]
    //Testdata
    init(testData: [MyModel] = []) {
        self.testData = testData
    }
    
    func apiToGetData(completion: @escaping ([MyModel]) -> ()) {
        completion(testData)
    }
}
