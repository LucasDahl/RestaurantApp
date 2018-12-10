//
//  AppDelegate.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/22/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Properties
    let window = UIWindow()
    let  locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Look for the location statues
        switch locationService.status {
            case .notDetermined, .denied, .restricted:
                let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
                locationViewController?.locationService = locationService
                window.rootViewController = locationViewController
            default:
                assertionFailure()// Will fix later, just for test
        }
        window.makeKeyAndVisible()
        
        return true
    }


} // End class

