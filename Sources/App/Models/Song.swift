import Fluent
import Vapor

final class Song: Model, Content {
    static let schema = "songs"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "artist_id") 
    var artist_id: UUID

    @Field(key: "album")
    var album: String


    init() { }

    init(id: UUID? = nil, title: String, artist_id: String, album: String) {
        self.id = id
        self.title = title
        self.album = album
        self.artist_id = UUID(uuidString: artist_id)!
    }
}