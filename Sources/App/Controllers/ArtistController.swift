import Fluent
import Vapor


struct ArtistController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let artist = try req.content.decode(Artist.self)
        return artist.save(on: req.db).map { _ in
            return req.redirect(to: "/artists")
        }
    }

    func read(_ req: Request) throws -> EventLoopFuture<View> {
        let allArtists = Artist.query(on: req.db).all()
        return allArtists.flatMap { artists in
            let data = ["artistList": artists]
            return req.view.render("artists", data)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Artist.self)
        return Artist.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { artist in
                artist.first_name = input.first_name
                artist.last_name = input.last_name
                artist.city = input.city
                return artist.save(on: req.db).map { _ in
                    return req.redirect(to: "/artists")
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Artist.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/artists")
            }
    }
}