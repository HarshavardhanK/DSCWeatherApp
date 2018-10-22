//
//  ViewController.swift
//  DSCWeatherApp
//
//  Created by Harshavardhan K on 21/10/18.
//  Copyright © 2018 Harshavardhan K. All rights reserved.
//

import UIKit
import CoreLocation

import SwiftyJSON
import Alamofire



class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let APIKEY = "55eba87715d97d1eac62891df01fb00f"
    let url = "https://api.openweathermap.org/data/2.5/weather"
    
    var weather = WeatherDataModel()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UIImageView!
    
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    ///******************************* MARK: - AlamoFire NETWORKING *******************************///
    ///
    ///
    
    func getWeatherData(url: String, parameters: Dictionary<String, String>) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if response.result.isSuccess {
                print("Success!")
                
                
                let weatherJSON: JSON = JSON(response.result.value!)
                //print(weatherJSON)
                print(weatherJSON)
                
                self.updateWeatherData(data: weatherJSON)
                
            } else {
                print("Error \(response.result.error)")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    ///******************************* MARK: - Parse JSON  *****************************************///
    ///
    
    func updateWeatherData(data: JSON) {
        
        if let temperature = data["main"]["temp"].double {
            
            weather.temperature = Int(temperature - 273.15)
            weather.city = data["name"].stringValue
            weather.condition = data["weather"][0]["id"].intValue
            
            let iconName = weather.updateWeatherIcon(condition: weather.condition)
            weather.weatherIcon = iconName
            
            updateInterfaceWithWeatherData()
            
        } else {
            cityLabel.text = "Weather Unavailable"
        }
        
    }
    
    
    ///******************************* MARK: - Location Manager Delegate Methods ********************///
    ///
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // TODO: Serve the coordinates
        // last value will be the most accurate
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.delegate = nil
            
            locationManager.stopUpdatingLocation()
            print("Longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let param: [String: String] = ["lat": String(latitude), "lon": String(longitude), "appid":APIKEY]
            
            getWeatherData(url: url, parameters: param)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Airplane mode, or blocked, or whatever
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    ///******************************* MARK: - UI Update *******************************************///
    ///
    
    func updateInterfaceWithWeatherData() {
        
        cityLabel.text = weather.city
        tempLabel.text = "\(weather.temperature)"
        weatherIconLabel.image = UIImage(named: weather.weatherIcon)
        
        print("City is \(weather.city)")
        
    }
    

}

