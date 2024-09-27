//
//  HomeViewController + Tableview.swift
//  VPD
//
//  Created by durodola on 24/09/2024.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCachedData {
            return cachedRepositories.count
        } else {
            return repositories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.8938775063, green: 0.9589306712, blue: 0.9707208276, alpha: 0.5)
            } else {
                cell.contentView.backgroundColor = .white
            }
        if isCachedData {
            cell.configureCachedCell(with: cachedRepositories[indexPath.row])
        } else {
            cell.configureCell(with: repositories[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isCachedData {
            gotoRepoDetailsCached(cachedRepo: cachedRepositories[indexPath.row], isCached: isCachedData)
        } else {
            gotoRepoDetails(repository: repositories[indexPath.row], isCached: isCachedData)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
