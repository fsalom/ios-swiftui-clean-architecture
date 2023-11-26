//
//  LocalCharacterDataSourceProtocol.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 14/11/23.
//

import Foundation

protocol LocalCharacterDataSourceProtocol {
    func getPagination(for page: Int) async throws -> PaginationDTO?
    func save(characters: [RMCharacterDTO], for page: Int) async throws
    func getFavorites() -> [RMCharacterDTO]
    func favOrUnfav(_ character: RMCharacterDTO)  async throws
}
