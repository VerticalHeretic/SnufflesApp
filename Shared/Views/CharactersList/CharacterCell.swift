//
//  CharacterCell.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 29/06/2023.
//

import SwiftUI

struct CharacterCell: View {
    var character: Character
    var isFavorite: Bool
    var locationTapAction: () -> Void
    var deleteAction: () -> Void
    var addAction: () -> Void 
    
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
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        locationTapAction()
                    }
            }
            
            Spacer()
            
            Button(isFavorite ? "Remove": "Add") {
                if isFavorite {
                    deleteAction()
                } else {
                    addAction()
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(character: .preview, isFavorite: false) {
            
        } deleteAction: {
            
        } addAction: {
            
        }

    }
}
