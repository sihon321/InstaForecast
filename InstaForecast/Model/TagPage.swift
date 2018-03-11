//
//  TagPage.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import ObjectMapper

class TagPage: NSObject, Mappable {
    var graphQL: GraphQL?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        graphQL   <- map["graphql"]
    }
}

class GraphQL: NSObject, Mappable {
    var hashtag: Hashtag?
    var user: User?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        hashtag   <- map["hashtag"]
        user      <- map["user"]
    }
}

class Hashtag: NSObject, Mappable {
    var edgeHashtagToMedia: EdgeHashtagToMedia?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        edgeHashtagToMedia   <- map["edge_hashtag_to_media"]
    }
}

class EdgeHashtagToMedia: NSObject, Mappable {
    var edges: [Edges]?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        edges   <- map["edges"]
    }
}

class Edges: NSObject, Mappable {
    var node: Node?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        node   <- map["node"]
    }
}

class Node: NSObject, Mappable {
    var displayURL = ""
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        displayURL   <- map["display_url"]
    }
}
