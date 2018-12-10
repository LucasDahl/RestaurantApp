//
//  LocationView.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 10/25/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

@IBDesignable class LocationView: BaseView {

    // Outlets
    @IBOutlet weak var allowButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!
    
    // Properties
    var didTapAllow: (() -> Void)?
    
    @IBAction func allowAction(_ sender: UIButton) {
        
        didTapAllow?()
        
    }
    
    @IBAction func denyAction(_ sender: UIButton) {
        
    }

}
