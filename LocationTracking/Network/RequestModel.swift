//
//  RequestModel.swift
//  LocationTracking
//
//  Created by Naveen on 15/04/21.
//

import Foundation

enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class RequestModel: NSObject {
    
    // MARK: - Properties
    var path: String {
        return ""
    }
    var parameters: [String: Any?] {
        return [:]
    }
    var headers: [String: String] {
        return [:]
    }
    var method: RequestHTTPMethod {
        return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
    }
    var body: [String: Any?] {
        return [:]
    }
}

// MARK: - Public Functions
extension RequestModel {
    
    func urlRequest() -> URLRequest {
        var endpoint: String = Constants.baseUrl.appending(path).removingPercentEncoding ?? ""
        
        for (index,parameter) in parameters.enumerated() {
            if let value = parameter.value as? String {
                if(index == 0) {
                    endpoint.append("?\(parameter.key)=\(value)")
                } else {
                    endpoint.append("&\(parameter.key)=\(value)")
                }
            }
        }
                
        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)
        
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                print("Request body parse error: \(error.localizedDescription)")
            }
        }
        
        return request
    }
}
