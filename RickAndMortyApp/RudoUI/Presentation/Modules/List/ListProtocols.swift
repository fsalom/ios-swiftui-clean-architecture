//
//  ListProtocols.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import Foundation

protocol ListViewModelProtocol: ObservableObject  {
    var searchText: String { get set }
    var characters: [Character] { get set }
    var hasMoreCharactersPendingToLoad: Bool { get set }
    func load() async
    func checkFavorites() async
    func loadMoreIfNeeded()
    func addOrRemove(this character: Character)
}


