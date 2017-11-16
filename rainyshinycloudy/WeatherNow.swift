//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by David Abernathy  on 11/13/17.
//  Copyright © 2017 David Abernathy . All rights reserved.
//

import Foundation
import Alamofire

class WeatherNow {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        _date = dateFormatter.string(from: Date())
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        //Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            //print(response)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    //print(self._cityName)
                }
                
                if let weather = dict["weather"] as? Array<AnyObject> {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        //print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let tempKelvin = main["temp"] as? Double {
                        
                        let tempFarenheit = (tempKelvin * (9/5)) - 459.67
                        
                        self._currentTemp = Double(round(10 * tempFarenheit / 10))
                        //print(self._currentTemp)
                    }
                }
                
            }
            completed()
        }
        
    }

    
}
