//
//  LocationViewModel.swift
//  LocationTracking
//
//  Created by Naveen on 16/04/21.
//

import Foundation

class LocationViewModel {
    
    private var networkService: NetworkService

    init(networkService: NetworkService = Networking()) {
        self.networkService = networkService
    }
    
    
    public func getUserDetails() {
        let user = UserModel()
        networkService.basicAuthentication(user: user, type: UserDetails.self) { (response) in
                        switch response {
                        case .success(let user):
                                print(user)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
        }
    }
}
