//
//  ListView.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 15/6/23.
//

import SwiftUI

struct ListView<VM>: View where VM: ListViewModelProtocol {
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
                    if viewModel.hasMoreCharactersPendingToLoad {
                        Button {
                            viewModel.loadMoreIfNeeded()
                        } label: {
                            Text(String.List.loadMore.localized)
                        }
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.black)
                        .foregroundColor(.white)
                    }
                }.navigationTitle(String.List.characters.localized)
                    .navigationBarTitleDisplayMode(.inline)
                    .accentColor(.black)
                    .searchable(text: $viewModel.searchText,
                                placement: .navigationBarDrawer(displayMode: .always),
                                prompt: String.List.search.localized)
                    .navigationBarItems(trailing:
                                            Text("\(viewModel.characters.count) \(String.General.characters.localized)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    )

            }
        }.task {
            await viewModel.load()
            await viewModel.checkFavorites()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListBuilder().build()
    }
}
