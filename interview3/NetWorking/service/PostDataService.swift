//
//  PostDataService.swift
//  interview3
//
//  Created by mengjiao on 12/24/20.
//

import Foundation

 protocol PostDataServiceDelegate {
    func  didPostEntity<T: Codable> (_ entity: T)
    func didFailWithError(error: Error)
}

///Post datas
/// example: create user, and deeds
struct PostDataService {
    
    var delegate: PostDataServiceDelegate?
    private var endpoint: Endpoint
    
    init(_ endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func performPostJson<T: Codable>(_ entity: T) {
        NetWorkingEngine.postJson(endpoint: endpoint, entity: entity) { (result: Result<ResponseData, Error>) in
            
            switch result {
            
            case .success(_):
                
                delegate?.didPostEntity(entity)
                
            case .failure(let error):
                
                print(error.localizedDescription)
                
                delegate?.didFailWithError(error: error)
            }
        }
    }
}
