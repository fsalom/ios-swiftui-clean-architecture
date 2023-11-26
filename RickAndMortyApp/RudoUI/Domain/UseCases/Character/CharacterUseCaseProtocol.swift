protocol CharacterUseCaseProtocol {
    func getCharactersAndNextPage(for page: Int) async throws -> ([Character], Bool)
    func getCharactersAndNextPageWhenSearching(this name: String, for page: Int) async throws -> ([Character], Bool)
    func getCharactersRelatedTo(this character: Character) async throws -> [Character]
    func getFavorites() async throws -> [Character]
    func saveFavorite(_ character: Character) async throws
    func removeFavorite(_ character: Character) async throws
    func setFavorites(to characters: [Character]) async throws -> [Character]
}
