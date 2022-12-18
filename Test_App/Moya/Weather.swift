//
//  Weather.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/8/22.
//

import Foundation
import ObjectMapper

//struct _WeatherData: Decodable {
//    let coordinates: _Coordinate
//
//    enum CodingKeys: String, CodingKey {
//        case coordinates = "coord"
//    }
//}
//
//struct _Coordinate: Decodable {
//    let longitude: Double?
//    let latitude: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case longitude = "lon"
//        case latitude = "lat"
//    }
//}
//
//struct _Weather: Decodable {
//    let id: Double?
//    let weather: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case weather
//    }
//}

class Weather: Mappable {
    var temp: Double?
    var humidity: Int?
    var country: String?
    var weatherInfo: [WeatherInfo]?
    var timeZone: Double?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        temp <- map["main.temp"]
        humidity <- map["main.humidity"]
        country <- map["sys.country"]
        weatherInfo <- map["weather"]
        timeZone <- map["timezone"]
    }
}

struct WeatherInfo: Mappable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        id <- map["main"]
        id <- map["description"]
        icon <- map["icon"]
        
    }
}

class HourlyWeather: Mappable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [List]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        cod <- map["cod"]
        message <- map["message"]
        cnt <- map["cnt"]
        list <- map["list"]
    }
}

struct List: Mappable {
    var dt: Int?
    var main: Main?
    var date: String?
    
    init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        dt <- map["dt"]
        main <- map["main"]
        date <- map["dt_txt"]
    }
}

struct Main: Mappable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var sea_level: Int?
    var grnd_level: Int?
    var humidity: Int?
    var temp_kf: Double?
    
    init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        temp <- map["temp"]
        feels_like <- map["feels_like"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
        pressure <- map["pressure"]
        sea_level <- map["sea_level"]
        grnd_level <- map["grnd_level"]
        humidity <- map["humidity"]
        temp_kf <- map["temp_kf"]
    }
}

struct WeatherDescription: Mappable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}

