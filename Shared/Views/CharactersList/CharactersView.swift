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
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                if !viewModel.characterName.isEmpty {
                    ForEach(viewModel.filteredCharacters) { character in
                        NavigationLink(destination: CharacterDetailsView(character: character), tag: character, selection: $viewModel.selectedCharacter) {
                            CharacterCell(character: character) {
                                viewModel.locationSelection(location: character.location)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } else if !viewModel.characterLocationName.isEmpty {
                    ForEach(viewModel.filteredCharacters) { character in
                        NavigationLink(destination: CharacterDetailsView(character: character), tag: character, selection: $viewModel.selectedCharacter) {
                            CharacterCell(character: character) {
                                viewModel.locationSelection(location: character.location)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } else {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailsView(character: character), tag: character, selection: $viewModel.selectedCharacter) {
                            CharacterCell(character: character) {
                                viewModel.locationSelection(location: character.location)
                            }
                        }
                        .buttonStyle(.plain)
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
        .task {
            viewModel.fetchCharacters(reset: false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
