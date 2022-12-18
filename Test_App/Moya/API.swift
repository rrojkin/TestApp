//
//  API.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/8/22.
//

import Foundation
import Moya

enum API {
    case getWeather(latitude: CGFloat, longitude: CGFloat)
    case getHourlyWeather(latitude: String, longitude: String, timeStampCount: Int)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5")!
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        case .getHourlyWeather:
            return "/forecast"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        guard let params = params else {
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var params: [String : Any]? {
        var params = [String : Any]()
        
        switch self {
        case .getWeather(let latitude, let longitude):
            params["lat"] = latitude
            params["lon"] = longitude
            params["appid"] = "a4a752c8b9c49257985f510ca705621e"
            params["units"] = "metric"
        case .getHourlyWeather(let latitude, let longitude, let timeStamp):
            params["lat"] = latitude
            params["lon"] = longitude
            params["appid"] = "a4a752c8b9c49257985f510ca705621e"
            params["cnt"] = "\(timeStamp)"
            params["units"] = "metric"
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            
        case .getWeather:
            return URLEncoding.queryString
        case .getHourlyWeather:
            return URLEncoding.queryString
        }
    }
}
