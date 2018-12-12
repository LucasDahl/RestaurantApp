//
//  NetworkService.swift
//  RestaurantApp
//
//  Created by Lucas Dahl on 12/10/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "HnCLklcO4HuIQYXG7aSTyZfIQAmsfFMQ7aGSmc6IBlZCfOQASJpRNEQEBlrnNwdJXdfiA5JPmbKCgQhlgnFAHocgllyW3hQfsY3pGk-P478obCmNWPKzEWqaKNEOXHYx"

enum YelpService  {
    enum BusinessesProvider: TargetType {
        case search(lat: Double, long: Double)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/search"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat, long):
                return .requestParameters(parameters: ["latitude": lat, "longitude": long, "limit": 1], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
        
        
    }
}
