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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
