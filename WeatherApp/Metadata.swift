//
//  Metadata.swift
//  WeatherApp
//
//  Created by Serhii Pianykh on 2017-02-16.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let BASE_FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let API_LAT = "lat="
let API_LON = "&lon="
let API_ID = "&appid="
let API_DAYS = "&cnt="
let API_KEY = "ca7d49477ff3aa7b3e4f554f168894bd"
let API_METRIC = "&units=metric"

let WEATHER_URL = "\(BASE_URL)\(API_LAT)44\(API_LON)-79\(API_ID)\(API_KEY)\(API_METRIC)"
let FORECAST_URL = "\(BASE_FORECAST_URL)\(API_LAT)44\(API_LON)-79\(API_DAYS)10\(API_ID)\(API_KEY)\(API_METRIC)"

typealias DownloadComplete = () -> ()
