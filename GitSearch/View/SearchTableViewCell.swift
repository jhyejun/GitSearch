//
//  SearchTableViewCell.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 15..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var numberOfReposLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.numberOfReposLabel.text = "Number of repos: 0"
    }
    
    func configure(data: User) {
        self.selectionStyle = .none
        
        self.getNumberOfRepos(data)
        if let imageURL = data.avatarImage {
            self.avatarImageView.kf.setImage(with: URL(string: imageURL))
        }
        self.IdLabel.text = data.loginId
    }
    
    func getNumberOfRepos(_ data: User) {
        APIManager.getRepoData(repoURL: data.repoURL ?? "" ) { response in
            self.numberOfReposLabel.text = "Number of repos: \(response.value?.count ?? 0)"
        }
    }
    
}
