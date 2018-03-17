//
//  ForecastProvider.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 17..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ForecastProvider {
    static func downloadForecast(cityName: String, completion: @escaping (WeatherInfo) -> Void) {
        Alamofire.request(ForecastRouter.forecast(cityName))
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    completion(WeatherInfo())
                    return
                }
                
                guard let responseJSON = response.result.value as? [String: Any],
                    let results =  Mapper<WeatherInfo>().map(JSON: responseJSON) else {
                        print("Invalid tag information received from the service")
                        completion(WeatherInfo())
                        return
                }
                
                completion(results)
        }
    }
}
