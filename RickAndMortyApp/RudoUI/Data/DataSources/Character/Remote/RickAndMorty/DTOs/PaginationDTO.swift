import Foundation

struct InfoDTO: Codable {
    var next: String?
}

struct PaginationDTO: Codable {
    var info: InfoDTO?
    var results = [RMCharacterDTO]()
}
