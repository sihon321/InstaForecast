//
//  ForecastProvider.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 17..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import Foundation
import Alamofire

class ForecastProvider {
  static func downloadForecast(cityName: String, completion: @escaping (WeatherInfo?) -> Void) {
    Alamofire.request(ForecastRouter.forecast(cityName))
      .responseJSON { response in
        guard response.result.isSuccess else {
          print("Error while fetching tags: \(String(describing: response.result.error))")
          completion(nil)
          return
        }
        
        guard let responseData = response.data else {
          print("didn't get any data from API")
          completion(nil)
          return
        }
        
        guard let results = try? JSONDecoder().decode(WeatherInfo.self,
                                                  from: responseData) else {
                                                        print(response.result.value as! [String: Any])
                                                        completion(nil)
                                                        return
        }
        
        completion(results)
    }
  }
}
