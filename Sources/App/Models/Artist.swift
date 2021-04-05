import Fluent
import Vapor

final class Artist: Model, Content {
    static let schema = "artists"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "first_name")
    var first_name: String

    @Field(key: "last_name")
    var last_name: String

    @Field(key: "city")
    var city: String

    init() { }

    init(id: UUID? = nil, first_name: String, last_name: String, city: String) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.city = city 
    }
}
