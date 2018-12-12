//
//  AppDelegate.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/22/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Properties
    let window = UIWindow()
    let locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessesProvider>()
    let jsonDecoder = JSONDecoder()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Convert the API data from snakeCase camel
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        
        
        // Look for the location statues
        switch locationService.status {
            case .notDetermined, .denied, .restricted:
                let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
                locationViewController?.locationService = locationService
                window.rootViewController = locationViewController
            default:
                let nav = storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
                window.rootViewController = nav
            loadBusinesses()
        }
        window.makeKeyAndVisible()
        
        return true
    }
    
    private func loadBusinesses() {
        
        service.request(.search(lat: 42.36, long: -71.05)) { (result) in
            switch result {
            case .success(let response):
                let root = try? self.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init)
                if let nav = self.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableTableViewController {
                    restaurantListViewController.vieModels = viewModels ?? []
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }


} // End class

