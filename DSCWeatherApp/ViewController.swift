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
    
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
    }
    
    ///******************************* MARK: - AlamoFire NETWORKING *******************************///
    ///
    ///
    
    ///******************************* MARK: - Parse JSON  *****************************************///
    ///
    ///
    
    ///******************************* MARK: - Location Manager Delegate Methods ********************///
    ///
    ///
    
    ///******************************* MARK: - UI Update *******************************************///
    ///
    ///
    
    
    
    
    
    


}

