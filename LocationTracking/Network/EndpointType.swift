//
//  EndpointType.swift
//  LocationTracking
//
//  Created by Naveen on 15/04/21.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: [String: Any?] { get }
}
