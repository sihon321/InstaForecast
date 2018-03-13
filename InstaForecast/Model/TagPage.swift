//
//  TagPage.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import ObjectMapper

class TagPage: Model {
    var graphQL: GraphQL?

    override func mapping(map: Map) {
        graphQL   <- map["graphql"]
    }
}

class GraphQL: Model {
    var hashtag: Hashtag?
    var user: User?

    override func mapping(map: Map) {
        hashtag   <- map["hashtag"]
        user      <- map["user"]
    }
}

class Hashtag: Model {
    var edgeHashtagToMedia: EdgeHashtagToMedia?

    override func mapping(map: Map) {
        edgeHashtagToMedia   <- map["edge_hashtag_to_media"]
    }
}

class EdgeHashtagToMedia: Model {
    var edges: [Edges]?

    override func mapping(map: Map) {
        edges   <- map["edges"]
    }
}

class Edges: Model {
    var node: Node?

    override func mapping(map: Map) {
        node   <- map["node"]
    }
}

class Node: Model {
    var displayURL = ""

    override func mapping(map: Map) {
        displayURL   <- map["display_url"]
    }
}
