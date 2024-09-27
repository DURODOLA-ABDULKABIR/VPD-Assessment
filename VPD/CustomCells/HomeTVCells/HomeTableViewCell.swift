//
//  HomeTableViewCell.swift
//  VPD
//
//  Created by durodola on 24/09/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with repositoryData: RepositoryResponseData) {
        nameLabel.text = repositoryData.name.capitalized
    }
    
    func configureCachedCell(with repositoryData: CoreDataRepository) {
        nameLabel.text = repositoryData.name?.capitalized
    }
    
    
    
}
