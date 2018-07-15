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

    // MARK: - Properties\
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatBlue, with: .light)
        
        APIManager.getUserData { userData in
            print(userData)
        }
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
