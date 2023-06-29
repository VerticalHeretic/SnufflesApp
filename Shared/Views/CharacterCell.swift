//
//  CharacterCell.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 29/06/2023.
//

import SwiftUI

struct CharacterCell: View {
    
    var character: Character
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .cornerRadius(10)
                
            } placeholder: {
                ProgressView()
            }
            .frame(minWidth: 48, idealWidth: 64, maxWidth: 80, minHeight: 48, idealHeight: 64, maxHeight: 80, alignment: .center)
            .accessibilityLabel("\(character.name) profile image")
            
            VStack(alignment: .leading){
                HStack(spacing: 4) {
                    Text(character.name)
                        .font(.headline)
                    
                    Text("is \(character.statusEmoji)")
                        .font(.subheadline)
                        .accessibilityLabel("is \(character.status.rawValue)")
                }
                
                Text("👽: \(character.species)")
                    .lineLimit(0)
                    .font(.subheadline)
                    .accessibilityLabel("species: \(character.species)")
                Text("🪐: \(character.location.name)")
                    .lineLimit(0)
                    .font(.subheadline)
                    .accessibilityLabel("from \(character.location.name)")
            }
        }
        .padding(.horizontal)
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: Character(id: 1,
                                           name: "Rick",
                                           status: .dead,
                                           species: "Human",
                                           type: "Type",
                                           gender: "Men",
                                           origin: .init(name: "Earth", url: "google.com"),
                                           location: .init(name: "Earth", url: "google.com"),
                                           image: "https://rickandmortyapi.com/api/character/avatar/18.jpeg",
                                           episode: [],
                                           url: "",
                                           created: ""))
    }
}
