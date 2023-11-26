//
//  CharacterRow.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 16/6/23.
//

import SwiftUI

struct CharacterRow: View {
    @Binding var character: Character

    var body: some View {
        HStack {
            ZStack {
                if let imageURL = URL(string: character.image) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .top)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .transition(.scale(scale: 0.1, anchor: .center))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80, alignment: .center)
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())

                    }
                }
                Circle()
                    .strokeBorder(Color.white,lineWidth: 2)
                    .background(Circle().foregroundColor(getStatusColor(for: character.status)))
                    .frame(width: 25, height: 25)
                    .offset(x: 27, y: 27)
            }
            VStack(alignment: .leading) {
                Text(character.name).font(.headline).foregroundColor(.black)
                Text(character.gender).font(.subheadline).foregroundColor(.black)
                Text(character.species).font(.subheadline).foregroundColor(.black)
            }
            Spacer()
            VStack {
                Button {
                    character.isFavorite.toggle()
                } label: {
                    Image(systemName: character.isFavorite ? "star.fill" : "star")
                }.foregroundColor(.black)
            }
        }.frame(maxWidth: .infinity)
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

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        let character = Character()
        CharacterRow(character: .constant(character))
    }
}
