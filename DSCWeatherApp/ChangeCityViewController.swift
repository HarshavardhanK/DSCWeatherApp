//
//  ChangeCityViewController.swift
//  DSCWeatherApp
//
//  Created by Harshavardhan K on 24/10/18.
//  Copyright © 2018 Harshavardhan K. All rights reserved.
//

import UIKit

class ChangeCityViewController: UIViewController, UITextFieldDelegate {
    
    var city: String = ""
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changeCityTextField.delegate = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        city = changeCityTextField.text!
//    }

}
