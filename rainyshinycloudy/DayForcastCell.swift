//
//  DayForcastCell.swift
//  rainyshinycloudy
//
//  Created by David Abernathy  on 11/26/17.
//  Copyright © 2017 David Abernathy . All rights reserved.
//

import UIKit

class DayForcastCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    @IBOutlet weak var rainPercentLbl: UILabel!
    
    // use dictionary to get appropriate abreviation for each day
    let dayAbrev = ["Monday":"Mon", "Tuesday":"Tue", "Wednesday":"Wed", "Thursday":"Thu", "Friday":"Fri", "Saturday":"Sat", "Sunday":"Sun"]
    
    func configureCell(forcast: Forcast) {
        
        
        dayLbl.text = dayAbrev[forcast.date]
        // change picture when have all the icons
        highTempLbl.text = String(forcast.highTemp)
        lowTempLbl.text = String(forcast.lowTemp)
        // add in rain percent. Don't currently have the data
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
    }
    
}

