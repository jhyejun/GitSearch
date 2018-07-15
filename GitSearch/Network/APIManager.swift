//
//  APIManager.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 12..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Alamofire
import ObjectMapper

// MARK: - APIManager
struct APIManager: APIService {
    
    // MARK: - UserData
    
    // MARK: Methods
    static func getUserData(_ completion: @escaping (DataResponse<User>) -> Void) {
        let urlString: String = self.url("/search/users")
        
        let headers: HTTPHeaders = [
            "Authorization" : "token bc7e666764a115a52ad8cfe4e5c17aca33daa5c0"
        ]
        let parameters: [String: String] = [
            "q" : "Jinseo"
        ]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: headers).validate(statusCode: 200 ..< 400).responseJSON { response in
            /* let response: DataResponse<User> = response.flatMapResult { json in
                if let user = Mapper<User>().map(JSONObject: json) {
                    return .success(user)
                }
                
                else {
                    // let error = MappingError(from: json, to: User.self)
                    // return .failure(error)
                    
                    return .failure(Error as! Error.self)
                }
            }
            
            completion(response) */
        }
    }
    
    // MARK: - RepoData
    
    // MARK: Methods
    func getRepoData() {
        
    }
    
}

extension DataResponse {
    
    func flatMapResult<T>(_ transform: (Value) -> Result<T>) -> DataResponse<T> {
        let result: Result<T>
        
        switch self.result {
        case .success(let value):
            result = transform(value)
            
        case .failure(let error):
            result = .failure(error)
        }
        
        return DataResponse<T>(
            request: self.request,
            response: self.response,
            data: self.data,
            result: result,
            timeline: self.timeline
        )
    }
    
}
