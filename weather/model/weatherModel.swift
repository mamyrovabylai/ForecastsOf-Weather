//
//  weatherModel.swift
//  weather
//
//  Created by Абылайхан on 06.11.17.
//  Copyright © 2017 Абылайхан. All rights reserved.
//

import UIKit
import Alamofire

class WeatherModel {
    private var _day: String!
    private var _maxTemp: String!
    private var _minTemp: String!
    private var _description: String!
    
    
    var day: String {
        if _day == nil{
            _day = ""
        }
            return _day
    }
    
    var min: String {
        if _minTemp == nil{
            _minTemp = ""
        }
            return _minTemp
    }
    
    var max: String{
        if _maxTemp == nil{
            _maxTemp = ""
        }
            return _maxTemp
    }
    var description: String {
        if _description == nil{
            _description = ""
        }
        return _description
    }
    init(list: [String: Any]){
        if let weather = list["weather"] as? [[String: Any]]{
            
            if let main = weather[0]["main"] as? String {
                self._description = main.capitalized
                
            }
        }
        if let main = list["main"] as? [String: Any]{
            if let max = main["temp_max"] as? Float {
                self._maxTemp = String(max-273.15)+"°"
            }
            if let min = main["temp_min"] as? Float{
                self._minTemp = String(min-273.15)+"°"
            }
        }
        if let date = list["dt"] as? Double{
            let unixDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, HH:mm"
            self._day = dateFormatter.string(from: unixDate)
        }
    }
    func downloadDetails(index: Int,completed : @escaping Completion){
        let  url = URL(string: forecastURLString)!
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            let result = response.result
            if let dict = result.value as? [String: Any]{
                
                if let list = dict["list"] as? [[String: Any]]{
                    
                        if let weather = list[index]["weather"] as? [[String: Any]]{
                            
                            if let main = weather[0]["main"] as? String {
                                self._description = main.capitalized
                                
                            }
                        }
                        if let main = list[index]["main"] as? [String: Any]{
                            if let max = main["temp_max"] as? Float {
                                self._maxTemp = String(max-273.15)+"°"
                            }
                            if let min = main["temp_min"] as? Float{
                                self._minTemp = String(min-273.15)+"°"
                            }
                        }
                    if let date = list[index]["dt"] as? Double{
                        let unixDate = Date(timeIntervalSince1970: date)
                        var dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMM d, HH:mm"
                        self._day = dateFormatter.string(from: unixDate)
                    }
                    
                }
            }
            completed()
        })
        
    }
}


