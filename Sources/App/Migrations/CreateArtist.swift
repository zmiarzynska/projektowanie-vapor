import Fluent

struct CreateArtist: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("artists")
            .id()
            .field("first_name", .string, .required)
            .field("last_name", .string, .required)
            .field("city", .string, .required)
            .create()            
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("artists").delete()
    }
}
