//
//  LocationViewController.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/25/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var locationView: LocationView!
    
    // Properties
    var locationService: LocationService?

    override func viewDidLoad() {
        super.viewDidLoad()

        // User tapped allow
        locationView.didTapAllow = {[weak self] in
            self?.locationService?.requestLocationAuthorization()
        }
        
        //  Get the location
        locationService?.didChangeStatus = {[weak self] success in
            
            if success {
                self?.locationService?.getLocation()
            }
            
        }
        
        // Store the location
        locationService?.newLocation = {[weak self] result in
            
            switch result {
            case .success(let location):
                print(location)
            case .failure(let error):
                assertionFailure("Error getting the location: \(error)")
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
