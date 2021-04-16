//
//  NetworkService.swift
//  LocationTracking
//
//  Created by Naveen on 15/04/21.
//

import Foundation

protocol NetworkService {
    func performNetworkTask<T: Codable>(endpoint: RequestModel,
                                        type: T.Type,
                                        completion: @escaping(Swift.Result<T, Error>) -> Void)
}
