//
//  FavoritesViewModel.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 28/6/23.
//

import Foundation

class FavoritesViewModel: ObservableObject, FavoritesViewModelProtocol {
    @Published var characters: [Character] = []
    @Published var errorOccurred: Bool = false

    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol) {
        self.useCase = useCase
    }

    func load() async {
        do {
            let characters = try await useCase.getFavorites()
            await MainActor.run() {
                self.characters = characters                
            }
        } catch {
            errorOccurred = true
        }
    }

    func addOrRemove(this character: Character) {
        Task {
            if character.isFavorite {
                try await self.useCase.saveFavorite(character)
            } else {
                try await self.useCase.removeFavorite(character)
            }
            await load()
        }

    }
}
