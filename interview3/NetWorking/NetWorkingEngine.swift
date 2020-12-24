//
//  NetWorkingEngine.swift
//  interview3
//
//  Created by mengjiao on 12/22/20.
//

import Foundation


class NetWorkingEngine {
    /// Executes web calls and decode the JSON response into Codeable objects
    /// - Parameters:
    ///    - endpoint: the endpoint to make HTTP request
    ///    - completion: the call back method
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) {
        // 1 configure url
        guard let url = configureUrl(endpoint) else {
            print("no url")
            return
        }
        
        // 2 configure request
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = endpoint.method
        
        print(url)
        
        // 3 configure session and task
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequst) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "UNKnown Error")
                return
            }
            
            guard response != nil, let data = data else {
                print("no response")
                return
            }
            
            // 4 decode json, and callback
            DispatchQueue.main.async {
                if let responseObjects = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObjects))
                } else {

                    // create error
                    let error = NetworkError.responseStatusError(status: 0, message: "UNknown Error") as NSError
                    completion(.failure(error))
                }
            }
        }
        
        // 5 resume task
        dataTask.resume()
    }
    
    /// using rest api post entity
    /// - Parameters:
    ///    - endpoint: the endpoint to make HTTP request
    ///    - completion: the call back method
    class func postJson<T: Codable>(endpoint: Endpoint, entity: T, completion: @escaping (Result<ResponseData, Error>) -> ()) {
        // 1 configure url
        guard let url = configureUrl(endpoint) else {
            print("no url")
            return
        }
        
        // 2 configure request
        var urlRequst = URLRequest(url: url)
        urlRequst.httpMethod = endpoint.method
        
        urlRequst.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        // 3 configure session and task
        let session = URLSession(configuration: .default)
        let jsonData111 = try? JSONEncoder().encode(entity)
        let dataTask = session.uploadTask(with: urlRequst, from: jsonData111) { data, response, error in
            
            // 4 error handling
            if let error = error {
                completion(.failure(error))
                print("Error making request: \(error.localizedDescription)")
                return
            }
            
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = data {
                if let responseObjects = try? JSONDecoder().decode(ResponseData.self, from: responseData) {
                    // 200 represents success created user
                    guard responseCode == 200 else {
                        // create error
                        let error = NetworkError.responseStatusError(status: responseCode, message: responseObjects.Result) as NSError
                        completion(.failure(error))
                        
                        return
                    }
                    
                    completion(.success(responseObjects))
                    
                } else {
                    // create error
                    let error = NetworkError.responseStatusError(status: 0, message: "UNknown Error") as NSError
                    completion(.failure(error))
                }
                return
            }
            
        }
        // 5 resume task
        dataTask.resume()
    }
    
    //MARK：- Help functions
    ///configure url
    /// - parameters
    /// - endpoint:  eg : XpowerwebEndpoint
    private class func configureUrl(_ endpoint: Endpoint) -> URL?{
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else {
            return nil
        }
        return url
    }
    
}


//MARK：- Error Handling
enum NetworkError: LocalizedError {
    case responseStatusError(status: Int, message: String)
}

extension NetworkError {
    public var errorDescription: String? {
        switch self {
        case let .responseStatusError(status, message):
            return "Error\(status): message \(message)"
        }
    }
}
