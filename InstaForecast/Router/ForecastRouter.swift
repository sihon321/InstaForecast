//
//  ForecastRouter.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 16..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import Foundation
import Alamofire

public enum ForecastRouter: URLRequestConvertible {
    static let baseURLPath = "http://api.openweathermap.org/data/2.5/"
    static let authenticationToken = ""
    
    case forecast(String)
    
    var method: HTTPMethod {
        switch self {
        case .forecast:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .forecast:
            return "/forecast"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .forecast(let cityName):
                return ["q": cityName, "mode": "json", "appid": ForecastRouter.authenticationToken]
            default:
                return [:]
            }
        }()
        
        let url = try ForecastRouter.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
//        request.setValue(ForecastRouter.authenticationToken, forHTTPHeaderField: "appid")
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

