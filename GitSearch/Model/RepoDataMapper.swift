//
//  RepoDataMapper.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 16..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import ObjectMapper

// MARK: - Repo
struct Repo: Mappable {
    
    // MARK: - Properties
    var count: Int = 0
    
    // MARK: - Methods
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.count <- map["public_repos"]
    }
}
