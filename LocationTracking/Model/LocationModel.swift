//
//  LocationModel.swift
//  LocationTracking
//
//  Created by Naveen on 15/04/21.
//

import Foundation


struct LocationModel: Codable {
    
    var latitude: Double?
    var longitude: Double?
    var name: String?
    var distance: Int?
}
