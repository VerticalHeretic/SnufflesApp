//
//  URLRequest+Characters.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation

extension URLRequest {
    
    static func getCharacters(page: Int?) -> Self {
        Self(components: .characters(page: page))
    }
    
    static func getCharacter(id: Int) -> Self {
        Self(components: .character(id: id))
    }
    
    static func getFilteredCharacters(filter: CharacterFilter) -> Self {
        Self(components: .characterFilter(filter: filter))
    }
}
