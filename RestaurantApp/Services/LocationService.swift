//
//  LocationService.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 12/10/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import CoreLocation

// This defines the case for success or failure
enum Result<T> {
    case success(T)
    case failure(Error)
}

final class LocationService: NSObject {
    
    // Properties
    var newLocation: ((Result<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?
    
    private let manager: CLLocationManager
    
    init(manger: CLLocationManager = .init()) {
        
        self.manager = manger
        super.init()
        manger.delegate = self
        
    }
    
    // Get the authorization status
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
        
    }
    
}

//=================
// MARK: - Delgates
//=================

extension LocationService: CLLocationManagerDelegate {
    
    // Failed to get location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        newLocation?(.failure(error))
        
    }
    
    // Got the location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            newLocation?(.success(location))
            
        }
        
        
    }
    
    // Check authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined, .restricted, .denied:
            didChangeStatus?(false)
        default:
            didChangeStatus?(true)
        }
        
    }
    
    
}
