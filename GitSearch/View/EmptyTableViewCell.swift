//
//  EmptyTableViewCell.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 16..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
