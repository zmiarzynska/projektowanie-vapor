import Fluent

struct CreateStudio: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("studios")
            .id()
            .field("brand_name", .string, .required)
            .field("city", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("studios").delete()
    }
}