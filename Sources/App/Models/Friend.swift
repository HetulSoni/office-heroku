//
//  Friend.swift
//  VaporHello
//
//  Created by Hetul on 18/02/17.
//
//

import Vapor
import Foundation

struct Friend: Model {
    var exists: Bool = false
    var id: Node?
    let name: String
    
    init(name: String) {
        self.name = name
        
    }
    
    // NodeInitializable
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        
    }
    
    // NodeRepresentable
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["id": id,
                               "name": name])
    }
    
    // Preparation
    static func prepare(_ database: Database) throws {
        try database.create("friends") { friends in
            friends.id()
            friends.string("name")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("friends")
    }
}
