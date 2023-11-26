//
//  FavoritesBuilder.swift
//  RudoUI
//
//  Created by Fernando Salom Carratala on 28/6/23.
//

import Foundation

class FavoritesBuilder {
    func build() -> FavoritesView<FavoritesViewModel> {
        let networkDataSource = RMRemoteDataSource(networkManager: NetworkManager())
        let cacheDataSource = LocalCacheDataSource(localManager: UserDefaultsManager())
        let repository = CharacterRepository(networkDatasource: networkDataSource,
                                             cacheDatasource: cacheDataSource)
        let useCase = CharacterUseCase(repository: repository)

        let viewModel = FavoritesViewModel(useCase: useCase)
        let view = FavoritesView(viewModel: viewModel)
        return view
    }
}
