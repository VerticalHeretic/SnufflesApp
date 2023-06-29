//
//  CharactersView.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import SwiftUI
import Factory

struct CharactersView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var favCharacters: FetchedResults<FavoriteCharacter>
    @StateObject var viewModel = CharactersViewModelImpl()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                if !viewModel.characterName.isEmpty || !viewModel.characterLocationName.isEmpty {
                    ForEach(viewModel.filteredCharacters) { character in
                        NavigationLink(destination: CharacterDetailsView(character: character), tag: character, selection: $viewModel.selectedCharacter) {
                            buildCharacterCell(character: character)
                        }
                        .buttonStyle(.plain)
                    }
                } else {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailsView(character: character), tag: character, selection: $viewModel.selectedCharacter) {
                            buildCharacterCell(character: character)
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
        .loadable(isLoading: $viewModel.isLoading)
        .errorable(error: $viewModel.error)
        .task {
            viewModel.fetchCharacters(reset: false)
        }
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Show Favorites") {
                    viewModel.showFavorites = true
                }
            }
            #else
            ToolbarItem {
                Button("Show Favorites") {
                    viewModel.showFavorites = true
                }
            }
            #endif
        }
        .sheet(isPresented: $viewModel.showFavorites) {
            FavoriteCharactersList()
        }
    }
    
    private func buildCharacterCell(character: Character) -> some View {
        CharacterCell(character: character,
                      isFavorite: isFavorite(character: character)) {
            viewModel.locationSelection(location: character.location)
        } deleteAction: {
            deleteFromFavorites(character: character)
        } addAction: {
            addToFavorites(character: character)
        }
    }
    
    private func isFavorite(character: Character) -> Bool {
        return favCharacters.contains { $0.id == character.id }
    }
    
    private func addToFavorites(character: Character) {
        let favCharacter = FavoriteCharacter(context: context)
        favCharacter.id = Int64(character.id)
        favCharacter.name = character.name
        favCharacter.image = character.image
        favCharacter.locationName = character.location.name
        favCharacter.species = character.species
        favCharacter.status = character.status.rawValue
        
        do {
            try context.save()
        } catch {
            Log.coreData.error(error.localizedDescription)
        }
    }
    
    private func deleteFromFavorites(character: Character) {
        guard let fav = favCharacters.first(where: { $0.id == character.id }) else { return }
        context.delete(fav)
        do {
            try context.save()
        } catch {
            Log.coreData.error(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
