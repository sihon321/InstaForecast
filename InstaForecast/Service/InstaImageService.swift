//
//  InstaImageService.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 7. 8..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import Foundation
import SwiftSoup
import SwiftyJSON
import ObjectMapper

class InstaImageService {

    func parseInstaInfoFromHTML(_ router: InstaRouter, closure: ([Edges]?) -> Void) {
        do {
            guard let url = URL(string: router.path.0) else {
                return
            }
            let isHashtag = router.path.1
            
            let html = try String(contentsOf: url)
            let doc = try SwiftSoup.parseBodyFragment(html)
            let body = try doc.getElementsByTag("script")
            var str: String?
            for element in body {
                str = element.dataNodes().filter { $0.getWholeData().hasPrefix("window._sharedData =") }.first?.getWholeData()
                if str != nil {
                    break
                }
            }
            
            guard let data = str else {
                return
            }
            let deprecatedString = "window._sharedData = "
            var jsonString = String(data[deprecatedString.endIndex...])
            jsonString = jsonString.trimmingCharacters(in: [";"])
            guard let jsonData = jsonString.data(using: .utf8),
                let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any]else {
                    return
            }
            
            let instaInfo = Mapper<InstaInfo>().map(JSON: json)
            if isHashtag {
                return closure(instaInfo?.entryData?.tagPage?.first?.graphQL?.hashtag?.edgeHashtagToMedia?.edges)
            } else {
                return closure(instaInfo?.entryData?.profilePage?.first?.graphQL?.user?.edgeOwnerToTimelineMedia?.edges)
            }
        } catch {
            // handle error
            print(error)
        }
        
        return
    }
}
