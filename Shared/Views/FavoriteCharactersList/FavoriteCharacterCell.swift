//
//  FavoriteCharacterCell.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 29/06/2023.
//

import Foundation
import SwiftUI

struct FavoriteCharacterCell: View {
    var character: FavoriteCharacter
    var isFavorite: Bool
    var deleteAction: () -> Void
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.image ?? "")) { image in
                image
                    .resizable()
                    .cornerRadius(10)
                
            } placeholder: {
                ProgressView()
            }
            .frame(minWidth: 48, idealWidth: 64, maxWidth: 80, minHeight: 48, idealHeight: 64, maxHeight: 80, alignment: .center)
            .accessibilityLabel("\(character.name ?? "") profile image")
            
            VStack(alignment: .leading){
                HStack(spacing: 4) {
                    Text(character.name ?? "")
                        .font(.headline)
                    
                    Text("is \(character.status ?? "")")
                        .font(.subheadline)
                        .accessibilityLabel("is \(character.status ?? "")")
                }
                
                Text("👽: \(character.species ?? "")")
                    .lineLimit(0)
                    .font(.subheadline)
                    .accessibilityLabel("species: \(character.species ?? "" )")
                Text("🪐: \(character.locationName ?? "")")
                    .lineLimit(0)
                    .font(.subheadline)
                    .accessibilityLabel("from \(character.locationName ?? "")")
            }
            
            Spacer()
            
            Button("Remove") {
                deleteAction()
            }
        }
        .padding(.horizontal)
    }
}
