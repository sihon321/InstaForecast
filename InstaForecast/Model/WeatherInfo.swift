//
//  WeatherInfo.swift
//  InstaForecast
//
//  Created by sihon321 on 2018. 3. 15..
//  Copyright © 2018년 Sihoon Oh. All rights reserved.
//
import Foundation

struct WeatherInfo: Codable {
  let city: City?
  let cnt: Int?
  let list: [List]?
}

struct City: Codable {
  let id: Int?
  let name, country: String?
  let coord: Coord?
}

struct Coord: Codable {
  var longtitude, latitude: Double?
  
  enum CodingKeys: String, CodingKey {
    case longtitude = "lon"
    case latitude = "lat"
  }
}

struct List: Codable {
  var dt: Int?
  var main: ListMain?
  var weather: [ListWeather]?
  var clouds: ListClouds?
  var wind: ListWind?
  var dtText: String?
  
  enum CodingKeys: String, CodingKey {
    case dt
    case main
    case weather
    case clouds
    case wind
    case dtText = "dt_txt"
  }
}

struct ListMain: Codable {
  let temp, tempMin, tempMax, pressure, seaLevel, grndLevel, humidity, tempKF: Double?
  
  enum CodingKeys: String, CodingKey {
    case temp
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case seaLevel = "sea_level"
    case grndLevel = "grnd_level"
    case humidity
    case tempKF = "temp_kf"
  }
}

struct ListWeather: Codable {
  let id: Int?
  let main, description, icon: String?
}

struct ListClouds: Codable {
  let all: Double?
}

struct ListWind: Codable {
  var speed, deg: Double?
}
