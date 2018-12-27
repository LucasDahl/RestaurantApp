//
//  Models.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 12/12/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import CoreLocation

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
    let distance:Double
    let id:String
    
    // This will format the distance
    static var numberFormatter: NumberFormatter {
        
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        return nf
        
    }
    
    var formattedDistance: String? {
        return RestaurantListViewModel.numberFormatter.string(from: distance as NSNumber)
    }
    
}

// Init for business
extension RestaurantListViewModel {
    
    // Set the properties
    init(business: Business) {
        self.name = business.name
        self.id = business.id
        self.imageUrl = business.imageUrl
        self.distance = business.distance / 1606.344
    }
}


// Create a location struct
struct Details: Decodable {
    
    // Properties
    let price: String
    let phone: String
    let isCloased: Bool
    let ratig: Double
    let name: String
    let photos: [URL]
    let coordinates: CLLocationCoordinate2D
    
}

// Make CLLocation confrom to Decodable
extension CLLocationCoordinate2D: Decodable {
    
    // Provide decoding keys
    enum CodingKeys: CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        
        // Create a container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Grt long and lat
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        
        // call init
        self.init(latitude: latitude, longitude: longitude)
        
    }
    
}

struct DetailsViewModel {
    
    let price: String
    let isOpen: String
    let phoneNumber: String
    let rating: String
    let imageUrls: [URL]
    let coordinate: CLLocationCoordinate2D
    
}

extension DetailsViewModel {
    init(details: Details) {
        
        // Set the properties
        self.price = details.price
        self.isOpen = details.isCloased ? "Closed" : "Open"
        self.phoneNumber = details.phone
        self.rating = "\(details.ratig) / 5"
        self.imageUrls = details.photos
        self.coordinate = details.coordinates
        
    }
}
