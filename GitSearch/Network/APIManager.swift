//
//  APIManager.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 12..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

// MARK: - APIManager
struct APIManager: APIService {
    
    // MARK: - UserData
    static var accessToken: String = ""
    
    // MARK: Methods
    static func getUserData(parameters: [String: Any], _ completion: @escaping (DataResponse<UserData>) -> Void) {
        let urlString: String = self.url("/search/users")
        
        if let infoDic: [String: Any] = Bundle.main.infoDictionary {
            if let token: String = infoDic["Authorization"] as? String {
                if let tokenData = Data(base64Encoded: token) {
                    self.accessToken = String(data: tokenData, encoding: .utf8)!
                }
            }
        }
        
        let headers: HTTPHeaders = [
            "Authorization" : self.accessToken
        ]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<UserData>) in
            print(response)
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getUserData] - \(error)")
            }
        }
    }
    
    // MARK: - RepoData
    
    // MARK: Methods
    static func getRepoData(users: String = "", _ completion: @escaping (DataResponse<UserData>) -> Void) {
        let urlString: String = self.url("/users/\(users)/repos")
        let headers: HTTPHeaders = [
            "Authorization" : "token 6b153b99dfef76a466e1d5f8ff613d3825691a7d"
        ]
        
        // Alamofire.request(urlString).validate(statusCode: 200 ..< 400).responseObject(completionHandler: <#T##(DataResponse<BaseMappable>) -> Void#>)
    }
    
}
