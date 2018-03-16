//
//  WeartherViewController.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 13..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class WeartherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var weatherInfo: WeatherInfo?
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast", method: .get,
                          parameters: ["q":"Seoul", "mode":"json", "appid": "5a05f152802650624cd2750f0b7f8c5e"])
            .responseJSON {
                response in
                if let result = response.result.value {
                    let json = result as? [String: Any]
                    weatherInfo = Mapper<WeatherInfo>().map(JSON: json!)
                    
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

