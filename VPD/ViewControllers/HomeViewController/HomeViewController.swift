//
//  ViewController.swift
//  VPD
//
//  Created by durodola on 24/09/2024.
//

import UIKit

class HomeViewController: UIViewController, RepositoriesProtocol {
    
    let usersNetworkManager = WeatherDetailsNetwork()
    var repositories = [RepositoryResponseData]()
    var cachedRepositories = [CoreDataRepository]()
    var refreshControl = UIRefreshControl()
    var isCachedData = false
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        getRepositories()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setUpViewController() {
        usersNetworkManager.delegate = self
        self.repositoriesTableView.delegate = self
        self.repositoriesTableView.dataSource = self
        self.repositoriesTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        loader.hidesWhenStopped = true
        refreshControl.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
        repositoriesTableView.refreshControl = refreshControl
        NotificationCenter.default.addObserver(self, selector: #selector(connectionLost), name: .connectionLost, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(connectionRestored), name: .connectionRestored, object: nil)
        emptyView.isHidden = true
    }
}
