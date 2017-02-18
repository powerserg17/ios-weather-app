//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Serhii Pianykh on 2017-02-05.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currTemperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currWeatherIconImage: UIImageView!
    @IBOutlet weak var currWeatherLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var location: CLLocation!
    
    var weather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            location = locationManager.location
            Location.sharedInstance.latitude = location.coordinate.latitude
            Location.sharedInstance.longitude = location.coordinate.longitude
            weather.downloadWeatherDetails {
                //UI to load data
                self.downloadForecast {
                    self.updateHeader()
                    self.tableView.reloadData()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }

    func updateHeader() {
        dateLabel.text = weather.date
        currTemperatureLabel.text = "\(String(weather.currentTemp))°C"
        locationLabel.text = weather.cityName
        currWeatherLabel.text = weather.weatherType
        currWeatherIconImage.image = UIImage(named: weather.weatherType.capitalized)
    }
    
    func downloadForecast(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL, method: .get).debugLog().responseJSON(completionHandler: { response in
            let result = response.result
            print(response)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                }
            }
            completed()
        })
    }

}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
}

