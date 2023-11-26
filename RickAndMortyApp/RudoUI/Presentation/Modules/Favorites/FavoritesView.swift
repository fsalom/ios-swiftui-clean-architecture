//
//  FavoritesView.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 28/6/23.
//

import SwiftUI

struct FavoritesView<VM>: View where VM: FavoritesViewModelProtocol {
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    ForEach($viewModel.characters) { $character in
                        NavigationLink(destination:  DetailCharacterBuilder().build(with: character)) {
                            CharacterRow(character: $character)
                                .padding(.trailing, 20)
                                .padding(.leading, 20)
                                .onChange(of: character) { newValue in
                                    viewModel.addOrRemove(this: newValue)
                                }
                        }
                    }
                }.navigationTitle(String.Favorites.title.localized)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }.task {
            await viewModel.load()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesBuilder().build()
    }
}
