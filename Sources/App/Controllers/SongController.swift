import Fluent
import Vapor


struct SongController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let song = try req.content.decode(Song.self)
        return song.save(on: req.db).map { _ in
            return req.redirect(to: "/songs")
        }
    }

    func read(_ req: Request) throws -> EventLoopFuture<View> {
        let allSongs = Song.query(on: req.db).all()
        return allSongs.flatMap { songs in
            let data = ["songList": songs]
            return req.view.render("songs", data)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Song.self)
        return Song.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { song in
                song.title = input.title
                song.album = input.album
                song.artist_id = input.artist_id
                return song.save(on: req.db).map { _ in
                    return req.redirect(to: "/songs")
                }
            }
    }


    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Song.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/songs")
            }
    }
}