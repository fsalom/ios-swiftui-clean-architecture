//
//  RelatedCharacterRow.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 20/6/23.
//

import SwiftUI

struct RelatedCharacterRow: View {
    var character: Character

    var body: some View {
        
        if let imageURL = URL(string: character.image) {
            AsyncImage(url: imageURL) { image in
                withAnimation(.easeInOut(duration: 1.0)) {
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }


            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(.white)
                    .background(.gray)
                    .opacity(0.5)
                    .clipShape(Circle())

            }
        }
    }
}

struct RelatedCharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        RelatedCharacterRow(character: Character())
    }
}
