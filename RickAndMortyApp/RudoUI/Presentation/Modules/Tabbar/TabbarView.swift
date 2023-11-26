//
//  TabbarView.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 28/6/23.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            ListBuilder().build()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
            FavoritesBuilder().build()
                .tabItem {
                    Label("Favoritos", systemImage: "star")
                }
        }
    }
}
