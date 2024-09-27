//
//  HomeViewController + Methods.swift
//  VPD
//
//  Created by durodola on 27/09/2024.
//

import UIKit

extension HomeViewController {
    @objc func connectionLost() {
        getCachedData()
    }

    @objc func connectionRestored() {
        getRepositories()
    }
    
    func getRepositories() {
        loader.startAnimating()
        usersNetworkManager.getUsers()
    }
    
    @objc func refreshTableData(_ sender: Any) {
        usersNetworkManager.getUsers()
       }
    
    func getCachedData() {
        isCachedData = true
        loader.stopAnimating()
        self.refreshControl.endRefreshing()
        if let cachedRepositories = RepositoryManager().fetchRepositories() {
            self.cachedRepositories = cachedRepositories
            self.repositoriesTableView.reloadData()
            if cachedRepositories.isEmpty {
                emptyView.isHidden = false
            }
        }
    }
    
    func displayFetchedData(_ repositories: [RepositoryResponseData]) {
        loader.stopAnimating()
        isCachedData = false
        self.repositories = repositories
        RepositoryManager().saveRepositories(repositories)
        self.refreshControl.endRefreshing()
        repositoriesTableView.reloadData()
        if repositories.isEmpty {
            emptyView.isHidden = false
        }
    }
    
    func gotoRepoDetails(repository: RepositoryResponseData, isCached: Bool) {
        if let repoDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController {
            repoDetailVC.repository = repository
            repoDetailVC.isCached = isCached
            self.present(repoDetailVC, animated: false, completion: nil)
        }
    }
    
    func gotoRepoDetailsCached(cachedRepo: CoreDataRepository, isCached: Bool) {
        if let repoDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController {
            repoDetailVC.cachedRepository = cachedRepo
            repoDetailVC.isCached = isCached
            self.present(repoDetailVC, animated: false, completion: nil)
        }
    }
}
