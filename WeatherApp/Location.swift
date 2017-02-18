//
//  Location.swift
//  WeatherApp
//
//  Created by Serhii Pianykh on 2017-02-18.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {
    }
    
    var latitude: Double!
    var longitude: Double!
    
}
