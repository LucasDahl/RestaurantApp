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
    //var window: UIWindow?
    let locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessesProvider>()
    let jsonDecoder = JSONDecoder()
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {



        // Convert the API data from snakeCase camel
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        //  Get the location
        locationService.didChangeStatus = { [weak self] success in

            if success {
                self?.locationService.getLocation()
            }

        }

        // Store the location
        locationService.newLocation = { [weak self] result in

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
                self.navigationController = nav
                window.rootViewController = nav
                locationService.getLocation()
                (nav?.topViewController as? RestaurantTableTableViewController)?.delegate = self

        }
        window.makeKeyAndVisible()

        return true
    }

    private func loadDetails(for viewController: UIViewController, id: String) {

        service.request(.details(id: id)) { [weak self](result) in
            switch result {
            case .success(let response):
                guard let strongSelf = self else {return}
                if let details = try? strongSelf.jsonDecoder.decode(Details.self, from: response.data) {
                    
                    let detailsViewModel = DetailsViewModel(details: details)
                    (viewController as? DetailsFoodViewController)?.viewModel = detailsViewModel
                    print(details)
                    
                }
            case .failure(let error):
                print(error)
            }

        }

    }

    private func loadBusinesses(with coordiante: CLLocationCoordinate2D) {

        service.request(.search(lat: coordiante.latitude, long: coordiante.longitude)) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let response):
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init).sorted(by: { $0.distance < $1.distance})
                if let nav = strongSelf.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableTableViewController {
                    restaurantListViewController.viewModels = viewModels ?? []
                } else if let nav = strongSelf.storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController {
                    strongSelf.navigationController = nav
                    strongSelf.window.rootViewController?.present(nav, animated: true) {
                        (nav.topViewController as? RestaurantTableTableViewController)?.delegate = self
                        (nav.topViewController as? RestaurantTableTableViewController)?.viewModels = viewModels ?? []
                    }
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
    func didTapCell(_ viewController: UIViewController, viewModel: RestaurantListViewModel) {
        loadDetails(for: viewController, id: viewModel.id)
    }
    
}
