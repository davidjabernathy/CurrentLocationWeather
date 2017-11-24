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
                
                //print(dict)
                if let forecast = dict["forecast"] as? Dictionary<String, AnyObject> {
                    
                    //print(forecast)
                    
                    if let forecastday = forecast["forecastday"] as? Array<AnyObject> {
                        
                        print(forecastday[0])
                        print("\n\n\n\n\n\n\n\n\n\n\n")
                        print(forecastday[1])
                        
                        for day in forecastday {
                          
                            let forcast = Forcast(weatherDict: day as! Dictionary<String, AnyObject>)
                            self.forcasts.append(forcast)
                            
                        }
                        
                    }
                    
                }
                
                    self.tableView.reloadData()
                
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
        // not all possible weather types have an image. Add a check to see if an image exists for that weather type, otherwise use a default
        // at some point find all possible weather types and get missing images
        // broken because of new weather type naming conditions
        // need to decide how to map the new weather types to images
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    
}

