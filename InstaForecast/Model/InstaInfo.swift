//
//  InstaInfo.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import ObjectMapper

class InstaInfo: Model {
    var entryData: EntryData?

    override func mapping(map: Map) {
        entryData   <- map["entry_data"]
    }
}

class EntryData: Model {
    var tagPage: [TagPage]?
    var profilePage: [ProfilePage]?

    override func mapping(map: Map) {
        tagPage   <- map["TagPage"]
        profilePage  <- map["ProfilePage"]
    }
}


