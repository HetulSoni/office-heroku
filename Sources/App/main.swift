import Vapor

let drop = Droplet()

drop.get("hello/:name") { req in
    
    return "Hello \(try! req.parameters.extract("name") as String )"
}

//drop.resource("posts", PostController())

drop.run()
