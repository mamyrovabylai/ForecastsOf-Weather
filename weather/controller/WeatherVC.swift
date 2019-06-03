//
//  ViewController.swift
//  weather
//
//  Created by Абылайхан on 06.11.17.
//  Copyright © 2017 Абылайхан. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController ,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentTempImage: UIImageView!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: TableView!
    var weatherModels:[weatherModel] = []
    var weatherModel: weatherModel!
    
    
    var currentWeather = CurrentWeather()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude,Location.sharedInstance.longitude)
            currentWeather.downloadWeatherDetails {
                self.updateUI()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    // tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NUMBER_KEY
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            weatherModels[indexPath.row].downloadDetails(index: indexPath.row, completed: {
                
                cell.updateUI(weatherModel: self.weatherModels[indexPath.row])
            })
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //update UI
    func updateUI(){
        currentDescriptionLabel.text = currentWeather.description
        currentLocationLabel.text = currentWeather.city
        currentTempLabel.text = currentWeather.temperature
        currentDateLabel.text = currentWeather.date
        currentTempImage.image = UIImage(named: currentWeather.description)
    }
    // forecast Data
    func downloadForecast(completed: Completion){
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            let result = response.result
            if let dict = result.value as? [String: Any]{
                if let list = dict["list"] as? [[String: Any]]{
                    for obj in list {
                        weatherModel = WeathreModel(obj: obj)
                        self.weatherModels.append(weatherModel)
                    }
                }
            }
            completed()
        })
    }
    
    


}

