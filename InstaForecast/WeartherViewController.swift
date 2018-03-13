//
//  WeartherViewController.swift
//  InstaForecast
//
//  Created by Sihoon Oh on 2018. 3. 13..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import UIKit
import Alamofire

class WeartherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast", method: .get,
                          parameters: ["q":"London", "mode":"json", "appid": "5a05f152802650624cd2750f0b7f8c5e"])
            .response {
                response in
                debugPrint(response.data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

