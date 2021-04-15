//
//  ViewController.swift
//  LocationTracking
//
//  Created by Naveen on 15/04/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager: CLLocationManager?
    private var isLocationGranted: Bool = false
    @IBOutlet weak var startLocation: UIButton!
    @IBOutlet weak var stopLocation: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersCurrentLocation()
    }
    
    
    private func getUsersCurrentLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.requestAlwaysAuthorization()
            locationManager?.distanceFilter = 100
            locationManager?.allowsBackgroundLocationUpdates = true
            updateLocationButtons(true)
        }
    }

    @IBAction func startTrackingAction(_ sender: UIButton) {
        if (isLocationGranted) {
            updateLocationButtons(false)
            locationManager?.startUpdatingLocation()
        }
    }
    
    
    @IBAction func stopTrackingAction(_ sender: UIButton) {
        if(isLocationGranted) {
            updateLocationButtons(true)
            locationManager?.stopUpdatingLocation()
        }
    }
    
    private func updateLocationButtons(_ isEnabled: Bool) {
        if isEnabled {
            stopLocation.backgroundColor = .lightGray
            startLocation.backgroundColor = .darkGray
        } else {
            stopLocation.backgroundColor = .darkGray
            startLocation.backgroundColor = .lightGray
        }
        startLocation.isEnabled = isEnabled
        stopLocation.isEnabled = !isEnabled
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            isLocationGranted = true
        } else {
            isLocationGranted = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Current location lat-long is = \(location.coordinate.latitude) \(location.coordinate.longitude)")
            
            if location.timestamp.timeIntervalSinceNow < -2 {
                return
            }

            if location.horizontalAccuracy < 0 {
                return
            }
            
            if (location.horizontalAccuracy > locationManager!.desiredAccuracy || location.timestamp.timeIntervalSinceNow > 2) {
                //Need to post updates to API
            } else {
                print("Last posted location doesnt exceed desired accuracy or time interval")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Get Location failed")
    }
}

