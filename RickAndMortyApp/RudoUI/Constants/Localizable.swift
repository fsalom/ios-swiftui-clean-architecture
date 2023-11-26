//
//  Localizable.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 26/6/23.
//

import Foundation

protocol Localizable: CustomStringConvertible {
    var rawValue: String { get }
}

extension Localizable {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }

    var uppercased: String {
        return self.localized.uppercased()
    }

    var description: String {
        return self.localized
    }

    func localized(with: CVarArg...) -> String {
        let text = String(format: self.localized, arguments: with)
        return text
    }
    func callAsFunction() -> String {
        return self.localized
    }
}

extension String {
    enum General: String, Localizable {
        case characters = "characters"
    }

    enum List: String, Localizable {
        case characters =  "list_characters"
        case loadMore = "list_load_more"
        case search = "list_search_placeholder"
    }

    enum Favorites: String, Localizable {
        case title =  "favorites_title"
    }

    enum Detail: String, Localizable {
        case relatedCharacters = "detail_related_characters"
        case relatedCharactersNotFound = "detail_related_characters_not_found"
        case error = "detail_error"
    }
}
