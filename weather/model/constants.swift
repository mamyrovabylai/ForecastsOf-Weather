//
//  constants.swift
//  weather
//
//  Created by Абылайхан on 07.11.17.
//  Copyright © 2017 Абылайхан. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
let BASE_URL2 = "https://api.openweathermap.org/data/2.5/forecast?"
let LAT = "lat="
let LAT_KEY = Location.sharedInstance.latitude
let LONG = "&lon="
let LONG_KEY = Location.sharedInstance.longitude
let APP_ID = "&appid="
let APP_KEY = "003df799a03a40b6a7685de9e752636e"
let NUMBER_KEY = 10
typealias Completion = () -> ()

let weatherURLString = "\(BASE_URL)\(LAT)\(LAT_KEY!)\(LONG)\(LONG_KEY)\(APP_ID)\(APP_KEY)"

let forecastURLString = "\(BASE_URL2)\(LAT)\(LAT_KEY!)\(LONG)\(LONG_KEY)\(APP_ID)\(APP_KEY)"
