//
//  WeatherInfo.swift
//  InstaForecast
//
//  Created by sihon321 on 2018. 3. 15..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//

import ObjectMapper

class WeatherInfo: Model {
    var city: City?
    var cnt = 0
    var list: [List]?
    
    override func mapping(map: Map) {
        city    <- map["city"]
        cnt     <- map["cnt"]
        list    <- map["list"]
    }
}

class City: Model {
    var id = 0
    var name = ""
    var coord: Coord?
    var country = ""
    
    override func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        coord   <- map["coord"]
        country <- map["country"]
    }
}

class Coord: Model {
    var longtitude = 0
    var latitude = 0
    
    override func mapping(map: Map) {
        longtitude      <- map["lon"]
        latitude        <- map["lat"]
    }
}

class List: Model {
    var dt = 0
    var listMain: ListMain?
    var listWeather: [ListWeather]?
    var listClouds: ListClouds?
    var listWind: ListWind?
    var dtText = ""
    
    override func mapping(map: Map) {
        dt              <- map["dt"]
        listMain        <- map["main"]
        listWeather     <- map["weather"]
        listClouds      <- map["clouds"]
        listWind        <- map["wind"]
        dtText          <- map["dt_txt"]
    }
}

class ListMain: Model {
    var temp = 0
    var tempMin = 0
    var tempMax = 0
    var pressure = 0
    var seaLevel = 0
    var grndLevel = 0
    var humidity = 0
    var tempKF = 0
    
    override func mapping(map: Map) {
        temp            <- map["temp"]
        tempMin         <- map["temp_min"]
        tempMax         <- map["temp_max"]
        pressure        <- map["pressure"]
        seaLevel        <- map["sea_level"]
        grndLevel       <- map["grnd_level"]
        humidity        <- map["humidity"]
        tempKF          <- map["temp_kf"]
    }
}

class ListWeather: Model {
    var id = 0
    var main = ""
    var descrip = ""
    var icon = ""
    
    override func mapping(map: Map) {
        id          <- map["id"]
        main        <- map["main"]
        descrip     <- map["description"]
        icon        <- map["icon"]
    }
}

class ListClouds: Model {
    var all = 0
    
    override func mapping(map: Map) {
        all     <- map["all"]
    }
}

class ListWind: Model {
    var speed = 0
    var deg = 0
    
    override func mapping(map: Map) {
        speed       <- map["speed"]
        deg         <- map["deg"]
    }
}
