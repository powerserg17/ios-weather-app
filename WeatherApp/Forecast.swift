//
//  Forecast.swift
//  WeatherApp
//
//  Created by Serhii Pianykh on 2017-02-17.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var date: String {
        get {
            if  _date == nil {
                _date = ""
            }
            return _date
        }
        set {
            _date = newValue
        }
    }
    
    var weatherType: String {
        get {
            if _weatherType == nil {
                _weatherType = ""
            }
            return _weatherType
        }
        set {
            _weatherType = newValue
        }
    }
    
    var highTemp: Double {
        get {
            if _highTemp == nil {
                _highTemp = 0
            }
            return _highTemp
        }
        set {
            _highTemp = newValue
        }
    }
    
    var lowTemp: Double {
        get {
            if _lowTemp == nil {
                _lowTemp = 0
            }
            return _lowTemp
        }
        set {
            _lowTemp = newValue
        }
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                self.lowTemp = min
            }
            
            if let max = temp["max"] as? Double {
                self.highTemp = max
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self.weatherType = main
            }
            
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "EEEE"
            self.date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
