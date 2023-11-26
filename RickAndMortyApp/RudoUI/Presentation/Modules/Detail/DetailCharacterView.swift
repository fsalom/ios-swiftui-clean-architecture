//
//  DetailCharacterView.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import SwiftUI

struct DetailCharacterView<VM>: View where VM: DetailCharacterViewModelProtocol {
    @ObservedObject var viewModel: VM
    
    var body: some View {
        VStack {
            if let url = URL(string: viewModel.character.image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            }
            Spacer()
            if viewModel.errorOccurred {
                HStack {
                    Text(String.Detail.error.localized)
                }.padding(16)
                    .frame(maxWidth: .infinity, idealHeight: 80)
                    .background(.red)
            } else {
                VStack(alignment: .leading) {
                    Text(String.Detail.relatedCharacters.localized)
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                        .fontWeight(.bold)
                    if viewModel.relatedCharacters.count == 0 {
                        Text(String.Detail.relatedCharactersNotFound.localized)
                            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                            .frame(maxWidth: .infinity)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.relatedCharacters) { character in
                                    NavigationLink(destination:  DetailCharacterBuilder().build(with: character)) {
                                        RelatedCharacterRow(character: character)
                                    }
                                }
                            }.padding(16)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .task {
                        await viewModel.getRelatedCharacters()
                    }

            }
        }.navigationTitle(viewModel.character.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
            Image(systemName: "circle.fill")
                .foregroundColor(getStatusColor(for: viewModel.character.status))
                .frame(width: 24, height: 24)
            )
    }

    func getStatusColor(for status: Character.RMStatus) -> Color {
        switch status {
        case .Dead:
            return .red
        case .Alive:
            return .green
        case .unknown:
            return .gray
        }
    }
}

struct DetailCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCharacterBuilder().build(with: Character())
    }
}
