//
//  MainViewController.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 11..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit
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
        
        self.registerTableViewCell()
        
        self.userSearchBar.delegate = self
        self.searchResultTableView.delegate = self
        self.searchResultTableView.dataSource = self
    }
    
    // 테이블뷰 셀 등록
    func registerTableViewCell() {
        self.searchResultTableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        self.searchResultTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
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
        self.totalCount = 0
        self.pageCount = 1
        
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            self.cellData.removeAll()
            self.searchResultTableView.reloadData()
            return
        }
        
        self.parameters = [
            "q" : searchText,
            "page" : 1,
            "per_page" : 20
        ]
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.2)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            self.setSearchTable(data: [User]())
        }
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 검색 결과값이 없을 때
        if self.cellData.isEmpty {
            return 1
        }
        
        // 검색 결과값이 있을 때
        else {
            return self.cellData.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 검색 결과값이 없을 때
        if self.cellData.isEmpty {
            return self.searchResultTableView.bounds.height
        }
        
        // 검색 결과값이 있을 때
        else {
            return 88
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 검색 결과값이 없을 때
        if self.cellData.isEmpty {
            self.searchResultTableView.setContentOffset(CGPoint.zero, animated: false)
            return tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell ?? UITableViewCell()
        }
            
        // 검색 결과값이 있을 때
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell {
                cell.configure(data: self.cellData[indexPath.row])
                return cell
            }
            
            return UITableViewCell()
        }
    }
    
    // TableView 데이터 더 불러오기
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 데이터의 총 개수에서 10개를 뺀 값번째의 셀을 불러올 때 실행하고 데이터의 총 개수는 20개보다 커야 실행한다.
        if indexPath.row == self.cellData.count - 5 && self.totalCount > 20 {
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
