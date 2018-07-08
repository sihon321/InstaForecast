//
//  InstaClient.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 7. 8..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import Foundation
import SwiftSoup
import SwiftyJSON
import ObjectMapper

enum InstaRouter {
    case search(word: String, isHashtag: Bool)
    
    var path: (String, Bool) {
        switch self {
        case .search(let word, let isHashtag):
            if isHashtag {
                guard let encodingWord = word.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                    return ("", false)
                }
                return ("https://www.instagram.com/tags/\(encodingWord)", true)
            } else {
                return ("https://www.instagram.com/\(word)", false)
            }
        }
    }
}
