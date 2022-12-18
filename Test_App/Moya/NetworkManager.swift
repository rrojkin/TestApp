//
//  NetworkManager.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/8/22.
//

import Foundation
import Moya
import Moya_ObjectMapper

class NetworkManager {
    static private let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    class func getWeather(lat: CGFloat, lon: CGFloat, success: ((Weather) -> ())?, failure: (() -> ())?) {
        provider.request(.getWeather(latitude: lat, longitude: lon)) { result in
            switch result {
            case .success(let response):
                guard let weather = try? response.mapObject(Weather.self) else {
                    failure?()
                    return
                }
                
                success?(weather)
            case .failure(_):
                failure?()
            }
        }
    }
    
    class func getHourlyWeather(lat: String, lon: String, timeStampCount: Int, success: ((HourlyWeather) -> ())?, failure: (() -> ())?) {
        provider.request(.getHourlyWeather(latitude: lat, longitude: lon, timeStampCount: timeStampCount)) { result in
            switch result {
            case .success(let response):
                guard let weather = try? response.mapObject(HourlyWeather.self) else {
                    failure?()
                    return
                }
                
                success?(weather)
            case .failure(_):
                failure?()
            }
        }
    }
    
}
