import Vapor
import VaporPostgreSQL

let drop = Droplet()

drop.preparations.append(Friend.self)
do {
    try drop.addProvider(VaporPostgreSQL.Provider.self)
} catch {
    print("Error adding provider: \(error)")
}

//drop.get("hello/:name") { req in
//    
//    return "Hello \(try! req.parameters.extract("name") as String )"
//}



drop.get("friends") { req in
    let friends = [Friend(name: "Sarah"),
                   Friend(name: "Steve"),
                   Friend(name: "Drew")]
    let friendsNode = try friends.makeNode()
    let nodeDictionary = ["friends": friendsNode]
    
    return try JSON(node: nodeDictionary)
}

//drop.post("save") { (req) in
////    print(req.data)
//    if let name = req.data["name"]?.string {
//        return "Saved Successfully"
//    }
//    throw Abort.custom(status: .badRequest , message: "Please Enter Username")
//}

drop.post("friend") { req in
    var friend = try Friend(node: req.json)
    try friend.save()
    return try friend.makeJSON()
}

drop.resource("posts", PostController())

drop.run()
