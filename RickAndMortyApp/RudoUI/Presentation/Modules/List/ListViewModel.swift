//
//  ListViewModel.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

class ListViewModel: ObservableObject, ListViewModelProtocol {
    @Published var characters: [Character] = []
    @Published var hasOcurredAnError: Bool = false
    @Published var hasMoreCharactersPendingToLoad: Bool = true
    @Published var searchText: String {
        didSet {
            if !searchText.isEmpty && searchText.count > 1 {
                saveCurrentCharactersToInitiateSearch()
                resetSearch()
                search(this: searchText)
            }
            if searchText.isEmpty {
                resetListWithPreviousCharacters()
            }
        }
    }

    var originalCharacters: [Character] = []
    var originalPage: Int = 1

    var searchHasNextPage: Bool {
        didSet {
            hasMoreCharactersPendingToLoad = searchHasNextPage
            page += searchHasNextPage ? 1 : 0
        }
    }

    var page: Int = 1
    var hasNextPage: Bool {
        didSet {
            hasMoreCharactersPendingToLoad = hasNextPage
            page += hasNextPage ? 1 : 0
        }
    }
    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol) {
        // MARK: general properties
        self.useCase = useCase
        self.hasNextPage = true

        // MARK: search properties
        self.searchText = ""
        self.searchHasNextPage = true
        self.originalPage = 1
    }

    func loadMoreIfNeeded() {
        Task {
            do {
                if searchText.isEmpty {
                    try await fetchCharacters()
                } else {
                    search(this: searchText)
                }
            } catch {
                handle(this: error)
            }
        }
    }

    func load() async {
        do {
            if characters.isEmpty {
                try await fetchCharacters()
            }
        } catch {
            handle(this: error)
        }
    }

    func checkFavorites() async {
        do {
            let characters = try await useCase.setFavorites(to: self.characters)
            await MainActor.run {
                self.characters = characters
            }
        } catch {
            handle(this: error)
        }
    }

    func fetchCharacters() async throws {
        if hasNextPage {
            let (characters, hasNextPage) = try await useCase.getCharactersAndNextPage(for: page)
            await MainActor.run {
                self.characters.append(contentsOf: characters)
                self.hasNextPage = hasNextPage
            }
        }
    }

    func addOrRemove(this character: Character) {
        Task {
            try await self.useCase.favOrUnfav(character)
        }
    }

    func search(this text: String) {
        Task {
            if searchHasNextPage {
                do {
                    let (characters, hasNextPage) = try await useCase.getCharactersAndNextPageWhenSearching(this: text, for: page)
                    await MainActor.run {
                        self.characters.append(contentsOf: characters)
                        self.searchHasNextPage = hasNextPage
                    }
                } catch {
                    handle(this: error)
                }
            }
        }
    }

    func resetListWithPreviousCharacters() {
        if !originalCharacters.isEmpty {
            self.hasMoreCharactersPendingToLoad = self.hasNextPage
            self.characters = self.originalCharacters
            self.page = self.originalPage
            self.originalCharacters.removeAll()
            self.originalPage = 1
        }
    }

    func saveCurrentCharactersToInitiateSearch() {
        if originalCharacters.isEmpty {
            originalCharacters = characters
            originalPage = page

            resetSearch()
        }
    }

    func resetSearch() {
        characters.removeAll()
        searchHasNextPage = true
        page = 1
    }

    func handle(this error: Error) {
        DispatchQueue.main.async {
            self.hasOcurredAnError = true
        }
    }
}
