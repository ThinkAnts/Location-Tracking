//
//  Network.swift
//  LocationTracking
//
//  Created by Naveen on 15/04/21.
//

import Foundation
import UIKit

final class Networking: NSObject, NetworkService, URLSessionDelegate {

    func performNetworkTask<T: Codable>(endpoint: RequestModel,
                                        type: T.Type,
                                        completion: @escaping(Swift.Result<T, Error>) -> Void) {        
        let urlSession = Foundation.URLSession.shared.dataTask(with: endpoint.urlRequest()) { (data, urlResponse, error) in
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

extension Networking {
    func URLSession(session: URLSession!, didReceiveChallenge challenge: URLAuthenticationChallenge!, completionHandler: ((URLSession.AuthChallengeDisposition, URLCredential?) -> Void)!) {

        if challenge.protectionSpace.authenticationMethod.compare(NSURLAuthenticationMethodServerTrust).rawValue == 0 {
            if challenge.protectionSpace.host.compare("HOST_NAME").rawValue == 0 {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            }

        } else if challenge.protectionSpace.authenticationMethod.compare(NSURLAuthenticationMethodHTTPBasic).rawValue == 0 {
            if challenge.previousFailureCount > 0 {
                print("Alert Please check the credential")
                completionHandler(Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
            } else {
                let credential = URLCredential(user:"username", password:"password", persistence: .forSession)
                completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential,credential)
            }
        }

    }

    func URLSession(session: URLSession!, task: URLSessionTask!, didReceiveChallenge challenge: URLAuthenticationChallenge!, completionHandler: ((URLSession.AuthChallengeDisposition, URLCredential?) -> Void)!){

        print("task-didReceiveChallenge")

        if challenge.previousFailureCount > 0 {
            print("Alert Please check the credential")
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
        } else {
            let credential = URLCredential(user:"username", password:"password", persistence: .forSession)
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential,credential)
        }


    }
}
