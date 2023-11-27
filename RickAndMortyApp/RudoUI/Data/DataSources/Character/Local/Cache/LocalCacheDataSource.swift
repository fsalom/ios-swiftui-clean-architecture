//
//  RMLocalDataSource.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 28/6/23.
//

import Foundation

class LocalCacheDataSource: LocalCharacterDataSourceProtocol {
    var localManager: LocalManagerProtocol
    let charactersKEY = "characters"

    init(localManager: LocalManagerProtocol) {
        self.localManager = localManager
    }

    func getPagination(for page: Int) async throws -> PaginationDTO? {
        let characterDTOs = self.getCharacters()
        let characterDTOsForThisPage = characterDTOs.filter({ $0.page == page})
        if characterDTOsForThisPage.count > 0 {
            return PaginationDTO(info: InfoDTO(next: "yes"), results: characterDTOsForThisPage)
        } else {
            return nil
        }
    }

    func save(characters: [RMCharacterDTO], for page: Int) async throws {
        var savedCharacterDTOs = self.getCharacters()
        let favoriteIDs  = self.getFavorites().map({$0.id})
        let characterIDsToInsert = characters.map({$0.id})
        savedCharacterDTOs.removeAll(where: {characterIDsToInsert.contains($0.id)})
        for var character in characters {
            if favoriteIDs.contains(character.id) {
                character.isFavorite = true
            }
            savedCharacterDTOs.append(character)
        }
        localManager.save(objectFor: charactersKEY, this: savedCharacterDTOs.sorted { $0.id > $1.id })
    }

    func favOrUnfav(_ character: RMCharacterDTO) async throws {
        var charactersDTO = self.getCharacters()
        if let _ = charactersDTO.first(where: { $0.id == character.id }) {
            charactersDTO.append(character)
        } else {
            charactersDTO.removeAll(where: {$0.id == character.id})
            charactersDTO.append(character)
        }
        localManager.save(objectFor: charactersKEY, this: charactersDTO)
    }

    private func getCharacter(with id: Int) -> RMCharacterDTO? {
        let characters = getCharacters()
        let charactersWithSameID = characters.filter({ $0.id == id })        
        return charactersWithSameID.first
    }

    private func getCharacters() -> [RMCharacterDTO] {
        guard let charactersDTO = localManager.retrieve(objectFor: charactersKEY, of: [RMCharacterDTO].self) else { return [] }
        return charactersDTO
    }

    func getFavorites() -> [RMCharacterDTO] {
        guard let favoritesDTO = localManager.retrieve(objectFor: charactersKEY, of: [RMCharacterDTO].self ) else { return []}
        return favoritesDTO.filter({$0.isFavorite == true})
    }
}
