//
//  CharactersViewModel.swift
//  SnufflesApp
//
//  Created by Łukasz Stachnik on 28/06/2023.
//

import Foundation
import Combine
import SwiftUI
import Factory

enum PagingState: Equatable {
    case loaded
    case loading
    case error
}

protocol CharactersViewModel: ObservableObject {
    func onItemAppear(_ character: Character)
    func fetchCharacters(reset: Bool)
    func locationSelection(location: Location)
}

final class CharactersViewModelImpl: CharactersViewModel {
    
    @Published var characters: [Character] = []
    @Published var filteredCharacters: [Character] = []
    @Published var state: PagingState = .loading
    @Published var characterName: String = ""
    @Published var characterLocationName: String = ""
    @Published var selectedCharacter: Character?
    @Published var showFavorites = false
    @Published var isLoading = false
    @Published var error: String?
    
    @Injected(\.charactersClient) var client
    var currentPage: Int = 1
    var nextPage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let threshold = 1
    private var currentTask: Task<Void, Never>? {
        willSet {
            if let task = currentTask {
                if task.isCancelled { return }
                task.cancel()
                // Setting a new task cancelling the current task
            }
        }
    }
    private var canLoadMorePages: Bool { nextPage != nil }
    
    init() {
        setupBindings()
    }
    
    func locationSelection(location: Location) {
        characterLocationName = characterLocationName == location.name ? "" : location.name
    }
    
    func onItemAppear(_ character: Character) {
        if !canLoadMorePages {
            return
        }
        
        if Task.isCancelled {
            return
        }
        
        if state == .loading {
            return
        }
        
        guard let index = characters.firstIndex(where: { $0.id == character.id }) else {
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -threshold)
        if index != thresholdIndex {
            return
        }
        
        state = .loading
        currentTask = Task {
            await getCharacters()
        }
    }
    
    func fetchCharacters(reset: Bool) {
        if reset {
            currentPage = 1
            nextPage = nil
            characters = []
        }
            
        currentTask = Task {
            await getCharacters()
        }
    }
    
    @MainActor fileprivate func getCharacters() async {
        do {
            self.isLoading = true
            error = nil
            let charactersResponse = try await client.getCharacters(page: currentPage)
            Log.network.info("Fetched characrers from page \(currentPage), with next url being: \(String(describing: charactersResponse.info.next))")
            nextPage = charactersResponse.info.next
            characters += charactersResponse.results
            if nextPage != nil {
                currentPage += 1
            }
            self.isLoading = false
            state = .loaded
        } catch {
            state = .error
            Log.network.error(error.localizedDescription)
            self.error = error.localizedDescription
        }
    }
    
    private func setupBindings() {
        $characterName
            .combineLatest($characters, $characterLocationName)
            .receive(on: RunLoop.main)
            .sink { [weak self] name, characters, location in
                self?.filteredCharacters = characters.filter { $0.name.contains(name) || $0.location.name == location }
            }
            .store(in: &cancellables)
    }
}
