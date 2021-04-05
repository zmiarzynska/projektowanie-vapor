import Fluent
import Vapor

final class Studio: Model, Content {
    static let schema = "studios"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "brand_name")
    var brand_name: String

    @Field(key: "city")
    var city: String

    init() { }

    init(id: UUID? = nil, brand_name: String, city: String) {
        self.id = id
        self.brand_name = brand_name
        self.city = city  

    }
}