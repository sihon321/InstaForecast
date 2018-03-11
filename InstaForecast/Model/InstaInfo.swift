//
//  InstaInfo.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 11..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import ObjectMapper

class InstaInfo: NSObject, Mappable {
    var entryData: EntryData?
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        entryData   <- map["entry_data"]
    }
    
    override init() {
        super.init()
    }
}

class EntryData: NSObject, Mappable {
    var tagPage: [TagPage]?
    var profilePage: [ProfilePage]?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        tagPage   <- map["TagPage"]
        profilePage  <- map["ProfilePage"]
    }
}


