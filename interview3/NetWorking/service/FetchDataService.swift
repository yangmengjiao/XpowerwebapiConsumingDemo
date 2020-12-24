//
//  FetchDataService.swift
//  interview3
//
//  Created by mengjiao on 12/24/20.
//
import Foundation

 protocol FetchDataServiceDelegate {
    func  didFetchData<T: Codable> (_ entity: T)
    func didFailWithError(error: Error)
    
}

///Fetch datas
/// example: pointstable, or daily deeds
struct FetchDataService<R: Codable> {
    
    var delegate: FetchDataServiceDelegate?
    private var endpoint: Endpoint
    
    init(_ endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func performFetchData() {
        NetWorkingEngine.request(endpoint: endpoint) { (result: Result<R, Error>) in
            switch result {
            case .success(let points):
                
                self.delegate?.didFetchData(points)
                
            case .failure(let error):
                print(error.localizedDescription)
                
                delegate?.didFailWithError(error: error)
            }
        }
    }
}
