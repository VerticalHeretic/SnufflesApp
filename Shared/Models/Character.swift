//
//  Character.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation

struct Character: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    
    var statusEmoji: String {
        switch status {
        case .alive:
            return "🖖🏻"
        case .dead:
            return "☠️"
        case .unknown:
            return "⁉️"
        }
    }
    
    #if DEBUG
    static let preview = Character(id: 1,
                            name: "Rick",
                            status: .dead,
                            species: "Human",
                            gender: "Men",
                            origin: .init(name: "Earth", url: "google.com"),
                            location: .init(name: "Earth", url: "google.com"),
                            image: "https://rickandmortyapi.com/api/character/avatar/18.jpeg")
    #endif
}

struct Location: Decodable, Hashable {
    let name: String
    let url: String
}

enum Status: String, Decodable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
