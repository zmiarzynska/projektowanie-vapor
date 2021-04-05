import Fluent

struct CreateSong: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("songs")
            .id()
            .field("title", .string, .required)
            .field("artist_id", .uuid, .required,.references("artists", "id"))
            .foreignKey("artist_id", references: "artists", "id", onDelete: .cascade)
            .field("album", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("songs").delete()
    }
}