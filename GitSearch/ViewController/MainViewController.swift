//
//  MainViewController.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 11..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit
import ChameleonFramework
import TextFieldEffects
import Alamofire

// MARK: - UIViewController
class MainViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var parameters = [String: Any]()
    var totalCount: Int = 0
    var pageCount: Int = 1
    var cellData = [User]()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userSearchBar.delegate = self
        self.searchResultTableView.delegate = self
        self.searchResultTableView.dataSource = self
        
        // Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatBlue, with: .light)
    }
    
    // 테이블뷰 데이터 받아오는 함수
    func setSearchTable(data: [User]) {
        APIManager.getUserData(parameters: self.parameters) { userData in
            if let count = userData.value?.totalCount { self.totalCount = count }
            if let users = userData.value?.users {
                self.cellData = data.isEmpty ? [User]() : self.cellData
                
                for user in users {
                    self.cellData.append(user)
                }
                
                self.searchResultTableView.reloadData()
            }
                
            else {
                print("Empty userData.value")
            }
        }
    }
    
}


// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
    // MARK: - Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 텍스트가 바뀌었지만 텍스트가 없는 경우 (예를 들면, 어떤 걸 쳤다가 모두 지웠을 때의 상황)
        guard !searchText.isEmpty else {
            self.parameters = [
                "q" : searchText,
                "page" : pageCount,
                "per_page" : 20
            ]
            
            self.searchResultTableView.reloadData()
            return
        }
        
        // 일반적인 텍스트가 수정될 때의 경우
        self.parameters = [
            "q" : searchText,
            "page" : pageCount,
            "per_page" : 20
        ]
        
        self.setSearchTable(data: [User]())
        self.searchResultTableView.reloadData()
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SearchTableViewCell", owner: self, options: nil)?.first as! SearchTableViewCell
        cell.selectionStyle = .none
        
        if let imageURL = self.cellData[indexPath.row].avatarImage {
            cell.avatarImageView.kf.setImage(with: URL(string: imageURL))
        }
        
        cell.IdLabel.text = self.cellData[indexPath.row].loginId
        
        if let numberOfRepo = self.cellData[indexPath.row].numberOfRepo {
            cell.numberOfReposLabel.text = "Number of repos: \(numberOfRepo)"
        }
        
        return cell
    }
    
    // TableView 데이터 더 불러오기
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 데이터의 총 개수에서 10개를 뺀 값번째의 셀을 불러올 때 실행하고 데이터의 총 개수는 20개보다 커야 실행한다.
        if indexPath.row == self.cellData.count - 10 && self.totalCount > 20 {
            // 페이지 카운팅
            if self.pageCount <= (self.totalCount / 20) {
                self.pageCount += 1
                self.parameters["page"] = self.pageCount as Any
                self.setSearchTable(data: self.cellData)
            }
            
            // 카운팅된 페이지 초기화
            else {
                self.pageCount = 1
            }
        }
    }
    
}
