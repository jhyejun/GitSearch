//
//  User.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 12..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import ObjectMapper

// MARK: - SearchResult
struct UserData: Mappable {
    
    // MARK: - Properties
    var totalCount: Int?
    var users: [User] = []
    
    // MARK: - Methods
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.totalCount <- map["total_count"]
        self.users <- map["items"]
    }
    
}

// MARK: - User
struct User: Mappable {
    
    // MARK: - Properties
    var avatarImage: String?
    var loginId: String?
    var numberOfRepo: Int?
    
    // MARK: - Methods
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.avatarImage <- map["avatar_url"]
        self.loginId <- map["login"]
        self.numberOfRepo <- map["id"]
    }
    
}
