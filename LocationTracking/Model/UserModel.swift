//
//  UserModel.swift
//  LocationTracking
//
//  Created by Ravi on 15/04/21.
//

import Foundation

struct UserModel: Codable {
    var username = "test/candidate"
    var password = "c00e-4764"
}


struct UserDetails: Codable {
    // MARK: - Properties
    var id: Int?
    var title: String?
}
