//
//  CurrentWeather.swift
//  weather
//
//  Created by Абылайхан on 07.11.17.
//  Copyright © 2017 Абылайхан. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _temperature: String!
    private var _description: String!
    private var _city: String! = ""
    
    var temperature: String {
        get{ if _temperature == nil {
                _temperature = ""
            }
            return _temperature
            
        }
        
    }
    
    var description: String{
        get{
            if _description == nil {
                _description = ""
            }
            return _description
        }
        
    }
    
    var city: String {
        
        get{
            if _city == nil {
                _city = ""
            }
            return _city
        }
        
    }
    

    //Date Formatting
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        let date = "Today, \(currentDate)"
        return date
    }
    
    //downloadWeatherDetails
    func downloadWeatherDetails(completed: @escaping Completion){
        let url = URL(string: weatherURLString)!
        print(weatherURLString)
        Alamofire.request(url).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? [String: Any]{
                if let main = dict["main"] as? [String: Any]{
                    if let degree = main["temp"] as? Float {
                        self._temperature = String(degree - 273.15)+"°"
                    }
                }
                
                if let weather = dict["weather"] as? [[String:Any]]{
                    if let main = weather[0]["main"] as? String{
                        self._description = main.capitalized
                    }
                }
                
                if let name = dict["name"] as? String{
                    self._city = name.capitalized
                }
            }
                completed()
            
        }
        
        
    }
    
    
    
   
}
