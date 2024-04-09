import Fluent
import Vapor

func routes(_ app: Application) throws {
app.get { req async in
        "It works!"
    }

    app.get("hello") { req -> String in
        let bottles = try req.content.decode(Bottles.self)
        return "There were \(bottles.count) bottles"
    }
    
    app.post("hello") { req -> String in
        let bottles = try req.content.decode(Bottles.self)
        return "There were \(bottles.count) bottles"
    }

    try app.register(collection: TodoController())
    try app.register(collection: UsersController())
}

struct Bottles: Content {
    let count: Int
}
