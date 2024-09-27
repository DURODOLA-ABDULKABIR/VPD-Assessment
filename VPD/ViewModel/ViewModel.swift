//
//  ViewModel.swift
//  WeatherApp
//
//  Created by durodola on 29/06/2024.
//

import Foundation

class WeatherDetailsNetwork {
    var delegate: RepositoriesProtocol?
    func getUsers() {
        NetworkService.shared.getRepositories() { result in
            switch result {
            case .success(let response):
                self.delegate?.getRepositorySuccess(repositories: response)
            case .failure(let error):
                print(error)
                self.delegate?.noResponse()
            }
        }
    }
}
