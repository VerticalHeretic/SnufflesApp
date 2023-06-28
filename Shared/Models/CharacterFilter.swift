//
//  CharacterFilter.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation

/// This model can be extended when needed for more fields, but for current impl I will need only those two https://rickandmortyapi.com/documentation/#filter-characters
struct CharacterFilter {
    let name: String?
    let location: Location?
}
