//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by David Abernathy  on 11/12/17.
//  Copyright © 2017 David Abernathy . All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "40b0efb96c0acfdfe171a48fc46e5452"

//let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=40b0efb96c0acfdfe171a48fc46e5452"

typealias DownloadComplete = () -> ()


//let FORCAST_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=40b0efb96c0acfdfe171a48fc46e5452"


// current weather url for apixu api
// forcast url also works 
// TODO use only one url instead of current and forcast
let CURRENT_WEATHER_URL = "https://api.apixu.com/v1/current.json?key=fbada9e9a65e4192903153527171611&q=39.9612,-82.9988"

// forcast url for apixu api
let FORCAST_URL = "https://api.apixu.com/v1/forecast.json?key=fbada9e9a65e4192903153527171611&q=39.9612,-82.9988&days=10"
