//
//  URLComponents+Characters.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation

extension URLComponents {

    private static let basePath = "/character"
    
    static func characters(page: Int?) -> Self {
        var queryItems: [URLQueryItem] = []
        
        if let page {
            queryItems.append(.init(name: "page", value: "\(page)"))
        }
        
        return Self(path: basePath, queryItems: queryItems)
    }
    
    static func character(id: Int) -> Self {
        return Self(path: basePath + "/\(id)")
    }
    
    static func characterFilter(filter: CharacterFilter) -> Self {
        var queryItems: [URLQueryItem] = []
        
        if let name = filter.name {
            queryItems.append(.init(name: "name", value: name))
        }
        
        if let location = filter.location {
            queryItems.append(.init(name: "location", value: location.name))
        }
        
        return Self(path: basePath, queryItems: queryItems)
    }
}
