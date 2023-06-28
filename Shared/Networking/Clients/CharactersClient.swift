//
//  CharactersClient.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation
import Factory

protocol CharactersClient {
    func getCharacters() async throws -> NetworkResponse<Character>
    func getCharacter(with id: Int) async throws -> Character
    func getFilteredCharacters(with filter: CharacterFilter) async throws -> NetworkResponse<Character>
}

struct CharactersClientImpl: CharactersClient {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getCharacters() async throws -> NetworkResponse<Character> {
        return try await urlSession.request(for: .getCharacters)
    }
    
    func getCharacter(with id: Int) async throws -> Character {
        return try await urlSession.request(for: .getCharacter(id: id))
    }
    
    func getFilteredCharacters(with filter: CharacterFilter) async throws -> NetworkResponse<Character> {
        return try await urlSession.request(for: .getFilteredCharacters(filter: filter))
    }
}

extension Container {
    var charactersClient: Factory<CharactersClient>  {
        Factory(self) { CharactersClientImpl() }
        // TODO: Probably can add .onPReview for mock on preview
    }
}
