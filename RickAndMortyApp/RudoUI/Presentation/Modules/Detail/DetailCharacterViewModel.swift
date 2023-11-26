//
//  DetailCharacterViewModel.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import Foundation

class DetailCharacterViewModel: ObservableObject, DetailCharacterViewModelProtocol {
    @Published var character: Character
    @Published var errorOccurred: Bool = false
    @Published var relatedCharacters: [Character] = []

    var useCase: CharacterUseCaseProtocol!

    init(useCase: CharacterUseCaseProtocol, character: Character) {
        self.useCase = useCase
        self.character = character
    }

    func getRelatedCharacters() async {
        do {
            let relatedCharacters = try await useCase.getCharactersRelatedTo(this: character)
            await MainActor.run {
                self.relatedCharacters = relatedCharacters
            }
        } catch {
            errorOccurred = true
        }
    }
}
