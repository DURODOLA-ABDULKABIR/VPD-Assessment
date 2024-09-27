//
//  UserDetailsViewController.swift
//  VPD
//
//  Created by durodola on 24/09/2024.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var repository: RepositoryResponseData?
    var cachedRepository: CoreDataRepository?
    var isCached = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        if isCached {
            if let url = URL(string: cachedRepository?.ownerAvatarURL ?? "") {
                profileImage.loadImage(from: url, placeholder: UIImage(systemName: "person.fill"))
                    }
            fullnameLabel.text = cachedRepository?.fullName
            urlLabel.text = cachedRepository?.url
            typeLabel.text = cachedRepository?.type
            descriptionLabel.text = cachedRepository?.repoDescription
        } else {
            if let url = URL(string: repository?.owner.avatarURL ?? "") {
                profileImage.loadImage(from: url)
                    }
            fullnameLabel.text = repository?.fullName
            urlLabel.text = repository?.owner.url
            typeLabel.text = repository?.owner.type
            descriptionLabel.text = repository?.description
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
