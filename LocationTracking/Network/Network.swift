//
//  Network.swift
//  LocationTracking
//
//  Created by Naveen on 15/04/21.
//

import Foundation

final class Networking: NetworkService {
    
    func basicAuthentication<T>(user: UserModel,
                                type: T.Type,
                                completion: @escaping (Result<T, Error>) -> Void) {
        
        
        let login = user.username
        let password = user.password

        let url = NSURL(string: "http://test.com/api/v1/example.json")
        let request = NSMutableURLRequest(url: url! as URL)

        let config = URLSessionConfiguration.default
        let userPasswordString = "\(login):\(password)"
        let userPasswordData = Data(userPasswordString.utf8)
        let base64EncodedCredential = userPasswordData.base64EncodedData()
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
        }
        task.resume()
    }
    

    func performNetworkTask<T: Codable>(endpoint: RequestModel,
                                        type: T.Type,
                                        completion: @escaping(Swift.Result<T, Error>) -> Void) {        
        let urlSession = URLSession.shared.dataTask(with: endpoint.urlRequest()) { (data, urlResponse, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            let response = Response(data: data)
            guard let decodedData = response.decode(type) else {
                completion(.failure(error!))
                return
            }
            completion(.success(decodedData))
        }
        urlSession.resume()
    }
}
