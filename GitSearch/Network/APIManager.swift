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
    
    // MARK: - AccessToken
    
    // MARK: Methods
    static func getAccessToken() -> HTTPHeaders {
        var accessToken: String = ""
        
        if let infoDic: [String: Any] = Bundle.main.infoDictionary {
            if let token: String = infoDic["Authorization"] as? String {
                if let tokenData = Data(base64Encoded: token) {
                    accessToken = String(data: tokenData, encoding: .utf8)!
                    
                }
            }
        }
        
        return ["Authorization" : accessToken]
    }
    
    // MARK: - UserData
    
    // MARK: Methods
    static func getUserData(parameters: [String: Any], _ completion: @escaping (DataResponse<UserData>) -> Void) {
        let urlString: String = self.url("/search/users")
        let headers: HTTPHeaders = self.getAccessToken()
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<UserData>) in
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
    static func getRepoData(repoURL: String, _ completion: @escaping (DataResponse<Repo>) -> Void) {
        let headers: HTTPHeaders = self.getAccessToken()
        
        Alamofire.request(repoURL, headers: headers).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<Repo>) in
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getRepoData] - \(error)")
            }
        }
    }
}
