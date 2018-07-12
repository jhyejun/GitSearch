//
//  MainViewController.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 11..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit
import ChameleonFramework
import Hero
import TextFieldEffects

// MARK: - UIViewController
class MainViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var gitIconImageView: UIImageView!
    @IBOutlet weak var searchTextField: AkiraTextField!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatBlue, with: .light)
        
        self.searchTextField.delegate = self
        
        self.gitIconImageView.hero.id = "gitIcon"
        self.searchTextField.hero.id = "search"
    }
    
    @IBAction func touchedSearchTextField(_ sender: Any) {
        // self.hero.modalAnimationType = .auto
        self.hero.replaceViewController(with: SearchResultViewController())
    }
    
}

// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    
    // MARK: - Methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // performSegue(withIdentifier: "goSearchResult", sender: nil)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // performSegue(withIdentifier: "goSearchResult", sender: nil)
    }
    
}
