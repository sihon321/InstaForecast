//
//  InstaInfo.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//
import Foundation

struct InstaInfo: Codable {
  let entryData: EntryData
  
  enum CodingKeys: String, CodingKey {
    case entryData = "entry_data"
  }
}

struct EntryData: Codable {
  let tagPage: [TagPage]?
  let profilePage: [ProfilePage]?
  
  enum CodingKeys: String, CodingKey {
    case tagPage = "TagPage"
    case profilePage = "ProfilePage"
  }
}

struct Graphql: Codable {
  let hashtag: Hashtag?
  let user: User?
}
