//
//  Models.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 12/12/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

struct  Root: Codable {
    
    // Array of business
    let businesses: [Business]
    
}

// Business tstruct
struct Business: Codable {
    
    // Properties
    let id:String
    let name:String
    let imageUrl:URL
    let distance:Double
    
}

// Restaurant list struct
struct RestaurantListViewModel {
    
    let name:String
    let imageUrl:URL
    let distance:String
    let id:String
    
}

// Init for business
extension RestaurantListViewModel {
    
    // Set the properties
    init(business: Business) {
        self.name = business.name
        self.id = business.id
        self.imageUrl = business.imageUrl
        self.distance = "\(business.distance / 1606.344)"
    }
}