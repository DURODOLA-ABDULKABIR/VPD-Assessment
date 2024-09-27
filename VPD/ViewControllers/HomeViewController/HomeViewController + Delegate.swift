//
//  HomeViewController + Delegate.swift
//  VPD
//
//  Created by durodola on 24/09/2024.
//

import UIKit

extension HomeViewController {
    
    func getRepositorySuccess(repositories: [RepositoryResponseData]) {
        displayFetchedData(repositories)
    }
    
    func noResponse() {
        getCachedData()
        self.showAlert(title: "Something went wrong", message: "Please try again later.")
    }
}

