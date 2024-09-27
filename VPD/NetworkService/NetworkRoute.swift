//
//  NetworkRoute.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import Foundation
enum Route {
    
    static let baseUrl = "https://api.github.com/"
    
    case fetchRepos
    
    var description: String {
        switch self {
        case .fetchRepos:
            return "repositories"
        }
    }
}
