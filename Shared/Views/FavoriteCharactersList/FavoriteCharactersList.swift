//
//  FavoriteCharactersList.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 29/06/2023.
//

import SwiftUI

struct FavoriteCharactersList: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var favCharacters: FetchedResults<FavoriteCharacter>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorites 👑")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    ForEach(favCharacters) { character in
                        FavoriteCharacterCell(character: character, isFavorite: true) {
                            context.delete(character)
                            do {
                                try context.save()
                            } catch {
                                Log.coreData.error(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct FavoriteCharactersList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCharactersList()
    }
}
