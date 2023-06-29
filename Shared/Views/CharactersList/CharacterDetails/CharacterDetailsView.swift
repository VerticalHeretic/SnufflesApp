//
//  CharacterDetailsView.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 29/06/2023.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    var character: Character
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .padding()
            .accessibilityLabel("\(character.name) profile image")
            
            VStack(alignment: .leading, spacing: 12) {
                Text("\(character.name) current livelihood status is: \(character.status.rawValue)")
                    .font(.title)
                
                Text("👽: \(character.species)")
                    .lineLimit(0)
                    .font(.title2)
                    .accessibilityLabel("species: \(character.species)")
                
                Text("🪐: \(character.location.name)")
                    .lineLimit(0)
                    .font(.title2)
                    .accessibilityLabel("from \(character.location.name)")
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle(character.name)
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(character: .preview)
    }
}
