//
//  URLRequest+Characters.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation

extension URLRequest {
    
    static var getCharacters: Self {
        Self(components: .characters)
    }
    
    static func getCharacter(id: Int) -> Self {
        Self(components: .character(id: id))
    }
    
    static func getFilteredCharacters(filter: CharacterFilter) -> Self {
        Self(components: .characterFilter(filter: filter))
    }
}
