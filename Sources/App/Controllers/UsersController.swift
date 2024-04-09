//
//  UsersController.swift
//
//
//  Created by Komeno on 2024/03/24.
//

import Vapor
import Fluent

struct UsersController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.post("api", "users", use: createHandler)
        routes.get("api", "users", use: createHandler)
        routes.get("api", "user", ":userID", use: getSingleHandler)
        routes.get("api", "user", ":userID", use: deleteHandler)
    }
}

func createHandler(req: Request) async throws -> User {
    let user = try req.content.decode(User.self)
    try await user.save(on: req.db)
    return user
}

func getAllHandler(req: Request) async throws -> [User] {
    try await User.query(on: req.db).all()
}

func getSingleHandler(req: Request) async throws -> User {
    guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
        throw Abort(.notFound)
    }
    
    return user
}

func deleteHandler(req: Request) async throws -> HTTPStatus {
    guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
        throw Abort(.notFound)
    }
    
    try await user.delete(on: req.db)
    
    return .ok
}
