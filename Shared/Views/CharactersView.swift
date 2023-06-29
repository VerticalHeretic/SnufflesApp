//
//  CharactersView.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import SwiftUI
import Factory

struct CharactersView: View {
    
    @StateObject var viewModel = CharactersViewModelImpl()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    if !viewModel.characterName.isEmpty {
                        ForEach(viewModel.filteredCharacters) { character in
                            CharacterCell(character: character)
                        }
                    } else {
                        ForEach(viewModel.characters) { character in
                            CharacterCell(character: character)
                                .onAppear {
                                    viewModel.onItemAppear(character)
                                }
                        }
                    }
                }
            }
            .navigationTitle("SnufflesApp 🚀")
            .searchable(text: $viewModel.characterName)
            .refreshable {
                viewModel.fetchCharacters(reset: true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
