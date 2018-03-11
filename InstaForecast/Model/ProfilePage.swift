//
//  FeedPage.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import ObjectMapper

class ProfilePage: NSObject, Mappable {
    var graphQL: GraphQL?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        graphQL   <- map["graphql"]
    }
}

class User: NSObject, Mappable {
    var edgeOwnerToTimelineMedia: EdgeOwnerToTimelineMedia?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        edgeOwnerToTimelineMedia   <- map["edge_owner_to_timeline_media"]
    }
}

class EdgeOwnerToTimelineMedia: NSObject, Mappable {
    var edges: [Edges]?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        edges   <- map["edges"]
    }
}
