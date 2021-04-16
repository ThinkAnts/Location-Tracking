//
//  LocationViewModel.swift
//  LocationTracking
//
//  Created by Naveen on 16/04/21.
//

import Foundation

final class LocationViewModel {
    
    private var networkService: NetworkService
    private var locationModel = LocationModel()
    
    
    init(networkService: NetworkService = Networking()) {
        self.networkService = networkService
    }
    
    
    public func updateUserLocation(latitude: Double, longitude: Double) {
        if longitude != 0.0 && latitude != 0.0 {
            locationModel.latitude = latitude
            locationModel.longitude = longitude
            
            networkService.performNetworkTask(endpoint: LocationRequestModel(locationModel: self.locationModel), type: UserModel.self) { (response) in
                switch response {
                case .success(let gamesList):
                    print(gamesList)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
