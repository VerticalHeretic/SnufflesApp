//
//  URLComponents+Init.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation

public extension URLComponents {
    
    init(schema: String = "https",
         host: String = "rickandmortyapi.com/api", // TODO: Probably could add some global configuration and change this on the fly with default value
         path: String,
         queryItems: [URLQueryItem]? = nil) {
        var components = URLComponents()
        components.scheme = schema
        components.path = host + path
        components.queryItems = queryItems
        self = components
    }
}
