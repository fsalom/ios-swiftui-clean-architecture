//
//  RickAndMortyRepository.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

final class CharacterRepository: CharacterRepositoryProtocol {
    var networkDatasource: RMCharacterDataSourceProtocol
    var cacheDatasource: LocalCharacterDataSourceProtocol

    init(networkDatasource: RMCharacterDataSourceProtocol,
         cacheDatasource: LocalCharacterDataSourceProtocol) {
        self.networkDatasource = networkDatasource
        self.cacheDatasource = cacheDatasource
    }

    func getPagination(for page: Int) async throws -> Pagination {        
        let networkPagination = try await networkDatasource.getPagination(for: page)
        guard let pagination = networkPagination else {
            return Pagination(hasNextPage: false, characters: [])
        }
        return pagination.toDomain()
    }

    func getPaginationWhenSearching(this name: String, for page: Int) async throws -> Pagination {
        let networkPagination = try await networkDatasource.getPaginationWhenSearching(this: name, for: page)
        guard let pagination = networkPagination else {
            return Pagination(hasNextPage: false, characters: [])
        }
        return pagination.toDomain()
    }

    func getFavorites() async throws -> [Character] {
        let favorites = try await cacheDatasource.getFavorites()
        return favorites.map{ $0.toDomain() }
    }

    func saveFavorite(_ character: Character) async throws {
        try await cacheDatasource.saveFavorite(character.toDTO())
    }

    func removeFavorite(_ character: Character) async throws {
        try await cacheDatasource.removeFavorite(character.toDTO())
    }
}
