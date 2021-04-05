import Fluent
import Vapor

func routes(_ app: Application) throws {



    let artistController = ArtistController()
    
    app.get("artists", use: artistController.read)
    
    app.post("artist", "create", use: artistController.create)
    app.post("artist", "update", ":id", use: artistController.update)
    app.post("artist", "delete", ":id", use: artistController.delete)


    let songController = SongController()

    app.get("songs", use: songController.read)
    
    app.post("song", "create", use: songController.create)
    app.post("song", "update", ":id", use: songController.update)
    app.post("song", "delete", ":id", use: songController.delete)


    let studioController = StudioController()

    app.get("studios", use: studioController.read)
    
    app.post("studio", "create", use: studioController.create)
    app.post("studio", "update", ":id", use: studioController.update)
    app.post("studio", "delete", ":id", use: studioController.delete)

}
