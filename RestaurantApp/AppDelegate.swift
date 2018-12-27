//
//  AppDelegate.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/22/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

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
        
        //  Get the location
        locationService.didChangeStatus = {[weak self] success in
            
            if success {
                self?.locationService.getLocation()
            }
            
        }
        
        // Store the location
        locationService.newLocation = {[weak self] result in
            
            switch result {
            case .success(let location):
                self?.loadBusinesses(with: location.coordinate)
            case .failure(let error):
                assertionFailure("Error getting the location: \(error)")
            }
            
        }
        
        // Look for the location statues
        switch locationService.status {
            case .notDetermined, .denied, .restricted:
                let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
                locationViewController?.delegate = self
                window.rootViewController = locationViewController
            default:
                let nav = storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
                window.rootViewController = nav
                locationService.getLocation()
                (nav?.topViewController as? RestaurantTableTableViewController)?.delegate = self
            
        }
        window.makeKeyAndVisible()
        
        return true
    }
    
    private func loadDetails(withId id: String) {
    
        service.request(.details(id: id)) { [weak self](result) in
            switch result {
            case .success(let responce):
                guard let strongSelf = self else {return}
                let details = try? strongSelf.jsonDecoder.decode(Details.self, from: responce.data)
                print("Details: \n\n \(details)")
            case .failure(let error):
                print(error)
            }
            
        }
    
    }
    
    private func loadBusinesses(with coordiante: CLLocationCoordinate2D) {
        
        service.request(.search(lat: coordiante.latitude, long: coordiante.longitude)) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let strongSelf = self else {return}
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init).sorted(by: { $0.distance < $1.distance})
                if let nav = strongSelf.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableTableViewController {
                    restaurantListViewController.vieModels = viewModels ?? []
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }


} // End class

extension AppDelegate: LocationAction, ListActions {
    
    // User tapped allow
    func didTapAllow() {
        locationService.requestLocationAuthorization()
    }
    
    // Get the cell that was tapped
    func didTapCell(_ vieModel: RestaurantListViewModel) {
        loadDetails(withId: vieModel.id)
    }
    
}
