//
//  APIService.swift
//  GitSearch
//
//  Created by 장혜준 on 2018. 7. 13..
//  Copyright © 2018년 장혜준. All rights reserved.
//

protocol APIService {
}

extension APIService {
    
    static func url(_ path: String) -> String {
        return "http://api.github.com" + path
    }
    
}
