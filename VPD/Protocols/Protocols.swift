//
//  Protocols.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import Foundation

protocol RepositoriesProtocol: AnyObject {
    func getRepositorySuccess(repositories: [RepositoryResponseData])
    func noResponse()
}
