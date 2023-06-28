//
//  CharactersView.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import SwiftUI
import Factory

struct CharactersView: View {
    
    @Injected(\.charactersClient) var client
    @State var characters: [Character] = []
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            ForEach(characters) { character in
                VStack {
                    HStack {
                        Text(character.name)
                    }
                }
            }
        }
        .task {
            do {
                let response = try await client.getCharacters()
                withAnimation {
                    characters = response.results
                }
            } catch {
                print(error) // TODO: Change to logger
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
