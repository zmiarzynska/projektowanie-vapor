import Fluent
import Vapor


struct StudioController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let studio = try req.content.decode(Studio.self)
        return studio.save(on: req.db).map { _ in
            return req.redirect(to: "/studios")
        }
    }

    func read(_ req: Request) throws -> EventLoopFuture<View> {
        let allStudios = Studio.query(on: req.db).all()
        return allStudios.flatMap { studios in
            let data = ["studioList": studios]
            return req.view.render("studios", data)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Studio.self)
        return Studio.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { studio in
                studio.brand_name = input.brand_name
                studio.city = input.city
                return studio.save(on: req.db).map { _ in
                    return req.redirect(to: "/studios")
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Studio.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/studios")
            }
    }
}