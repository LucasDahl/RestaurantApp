//
//  LocationViewController.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/25/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

protocol LocationAction: class {
    func didTapAllow()
}

class LocationViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var locationView: LocationView!
    
    // Properties
    weak var delegate: LocationAction?

    override func viewDidLoad() {
        super.viewDidLoad()

        // User tapped allow
        locationView.didTapAllow = {
            self.delegate?.didTapAllow()
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
