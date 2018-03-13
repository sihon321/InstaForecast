//
//  FeedPage.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import ObjectMapper

class ProfilePage: Model {
    var graphQL: GraphQL?

    override func mapping(map: Map) {
        graphQL   <- map["graphql"]
    }
}

class User: Model {
    var edgeOwnerToTimelineMedia: EdgeOwnerToTimelineMedia?

    override func mapping(map: Map) {
        edgeOwnerToTimelineMedia   <- map["edge_owner_to_timeline_media"]
    }
}

class EdgeOwnerToTimelineMedia: Model {
    var edges: [Edges]?

    override func mapping(map: Map) {
        edges   <- map["edges"]
    }
}
