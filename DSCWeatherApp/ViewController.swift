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
        locationManager.startUpdatingHeading()
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
                
                self.updateWeatherData(data: weatherJSON)
                
            } else {
                print("Error \(response.result.error)")
                //self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    ///******************************* MARK: - Parse JSON  *****************************************///
    ///
    ///
    
    ///******************************* MARK: - Location Manager Delegate Methods ********************///
    ///
    ///
    
    ///******************************* MARK: - UI Update *******************************************///
    ///
    
    func updateInterfaceWithWeatherData() {
        
        cityLabel.text = weather.city
        tempLabel.text = "\(weather.temperature)"
        weatherIconLabel.image = UIImage(named: weather.weatherIcon)
        
    }

    
    
    
    
    
    func updateWeatherData(data: JSON) {
        
        if let temperature = data["main"]["temp"].double {
            
            weather.temperature = Int(temperature - 273.15)
            weather.city = data["main"]["city"].stringValue
            weather.condition = data["weather"][0]["id"].intValue
            
            let iconName = weather.updateWeatherIcon(condition: weather.condition)
            weather.weatherIcon = iconName
            
            updateInterfaceWithWeatherData()
            
        } else {
            cityLabel.text = "Weather Unavailable"
        }
        
    }
    
    

}

