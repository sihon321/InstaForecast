//
//  TagPage.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//
import Foundation

struct TagPage: Codable {
  let graphql: Graphql?
}

struct Hashtag: Codable {
  let edgeHashtagToMedia: EdgeHashtagToMedia
  
  enum CodingKeys: String, CodingKey {
    case edgeHashtagToMedia = "edge_hashtag_to_media"
  }
}

struct EdgeHashtagToMedia: Codable {
    var edges: [EdgeHashtagToMediaEdge]
}

struct EdgeHashtagToMediaEdge: Codable {
  let node: PurpleNode
}

struct PurpleNode: Codable {
  let displayURL: String
  
  enum CodingKeys: String, CodingKey {
    case displayURL = "display_url"
  }
}

