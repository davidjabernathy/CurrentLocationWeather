//
//  Location.swift
//  rainyshinycloudy
//
//  Created by David Abernathy  on 11/14/17.
//  Copyright © 2017 David Abernathy . All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
