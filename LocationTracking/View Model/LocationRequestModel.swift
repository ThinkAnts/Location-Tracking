//
//  LocationRequestModel.swift
//  LocationTracking
//
//  Created by Ravi on 16/04/21.
//

import Foundation


final class LocationRequestModel: RequestModel {
    
    // MARK: - Properties
    private var locationModel: LocationModel

    init(locationModel: LocationModel) {
        self.locationModel = locationModel
    }
    
    
    override var path: String {
        return Constants.updateLocation
    }

    override var method: RequestHTTPMethod {
        return RequestHTTPMethod.post
    }
    
    override var body: [String : Any?] {
        return [
            "lat": locationModel.latitude,
            "lng": locationModel.longitude
        ]
    }
}
