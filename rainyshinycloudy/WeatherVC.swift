//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by David Abernathy  on 11/4/17.
//  Copyright © 2017 David Abernathy . All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: WeatherNow!
    var forcast: Forcast!
    var forcasts = [Forcast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //print(CURRENT_WEATHER_URL)
        
        currentWeather = WeatherNow()
        

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //print(currentLocation)
            print(Location.sharedInstance.longitude, Location.sharedInstance.latitude)
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
        currentWeather.downloadWeatherDetails {
            self.downloadForcastData {
                self.updateMainUI()
            }
        }
    }
    
    func downloadForcastData(completed: @escaping DownloadComplete) {
        
        //Download forcast weather data for Tableview
        let forcastURL = URL(string: FORCAST_URL)!
        Alamofire.request(forcastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    var lastDay = ""
                    var index = 0
                    for obj in list {
                        let forcast = Forcast(weatherDict: obj)
                        
                        //print(forcast._lowTemp)
                        //print("-----------------------------------")
                        
                        
                        if(forcast.date != lastDay) {
                            self.forcasts.append(forcast)
                            lastDay = forcast.date
                            index += 1
                        } else {
                            if(self.forcasts[index - 1].lowTemp > forcast.lowTemp) {
                                self.forcasts[index - 1]._lowTemp = forcast.lowTemp
                            }
                            if(self.forcasts[index - 1].highTemp < forcast.highTemp) {
                                self.forcasts[index - 1]._highTemp = forcast.highTemp
                            }
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                
            }
            completed()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forcast = forcasts[indexPath.row]
            cell.configureCell(forecast: forcast)
            return cell
            
        } else {
            return WeatherCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    func updateMainUI() {
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(currentWeather.currentTemp)
        currentLocationLabel.text = currentWeather.cityName
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    
}

