//
//  DetailCharacterProtocols.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import Foundation

protocol DetailCharacterViewModelProtocol: ObservableObject  {
    var character: Character { get set }
    var errorOccurred: Bool { get set }
    var relatedCharacters: [Character] { get set }
    func getRelatedCharacters() async
}
