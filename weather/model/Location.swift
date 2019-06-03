//
//  Location.swift
//  weather
//
//  Created by Абылайхан on 08.11.17.
//  Copyright © 2017 Абылайхан. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() { }
    
    var latitude: Double!
    var longitude: Double!
}
