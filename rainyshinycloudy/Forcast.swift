//
//  Forcast.swift
//  rainyshinycloudy
//
//  Created by David Abernathy  on 11/13/17.
//  Copyright © 2017 David Abernathy . All rights reserved.
//

import UIKit
import Alamofire


class Forcast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: Double! //he used string, could cause probs
    var _lowTemp: Double!  //he used string, could cause probs
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let main = weatherDict["main"] as? Dictionary<String, AnyObject> {
            
            if let min = main["temp_min"] as? Double {
                    
                let tempFarenheit = (min * (9/5)) - 459.67
                    
                self._lowTemp = Double(round(10 * tempFarenheit / 10))
                
            }
            
            if let max = main["temp_max"] as? Double {
                
                let tempFarenheit = (max * (9/5)) - 459.67
                
                self._highTemp = Double(round(10 * tempFarenheit / 10))
                
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }

        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .full
            dateformatter.dateFormat = "EEEE"
            dateformatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
            
        }
  
    }
    
}


extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}









