//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Serhii Pianykh on 2017-02-18.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func configureCell(forecast: Forecast) {
        lowTempLabel.text = String(forecast.lowTemp)
        highTempLabel.text = String(forecast.highTemp)
        weatherTypeLabel.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: "\(forecast.weatherType) Mini")
    }
    

}
