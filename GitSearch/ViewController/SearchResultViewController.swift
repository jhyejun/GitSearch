//
//  SearchResultViewController.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 12..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit
import TextFieldEffects

// MARK: - UIViewController
class SearchResultViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var gitIconImageView: UIImageView!
    @IBOutlet weak var searchTextField: AkiraTextField!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled = true
        self.gitIconImageView.hero.id = "gitIcon"
        self.searchTextField.hero.id = "search"
    }

}
