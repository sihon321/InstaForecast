//
//  FeedPage.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//
import Foundation

struct ProfilePage: Codable {
  let graphql: Graphql?
}

struct User: Codable {
  let edgeOwnerToTimelineMedia: EdgeOwnerToTimelineMedia
  
  enum CodingKeys: String, CodingKey {
    case edgeOwnerToTimelineMedia = "edge_owner_to_timeline_media"
  }
}

struct EdgeOwnerToTimelineMedia: Codable {
  let edges: [EdgeHashtagToMediaEdge]
}
