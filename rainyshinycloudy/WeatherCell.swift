//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by David Abernathy  on 11/14/17.
//  Copyright © 2017 David Abernathy . All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    

    func configureCell(forecast: Forcast) {
        /*
        // broken because of new weather type naming conditions
        // need to decide how to map the new weather types to images
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        highTempLabel.text = String(forecast.highTemp)
        lowTempLabel.text = String(forecast.lowTemp)
        
        */
    }

}
