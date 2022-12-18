//
//  City.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/15/22.
//

import Foundation
import UIKit

struct City {
    var name: String
    var lat: CGFloat
    var long: CGFloat
    var temp: Double
    var icon: String?
    var time: String?
    
    public init(name: String, lat: CGFloat, long: CGFloat, temp: Double) {
        self.name = name
        self.lat = lat
        self.long = long
        self.temp = temp
    }
}
