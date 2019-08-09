//
//  Location.swift
//  Threads
//
//  Created by Molnár Csaba on 2019. 08. 09..
//  Copyright © 2019. Molnár Csaba. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic public private(set) var latitude = 0.0
    @objc dynamic public private(set) var longitude = 0.0
    
    convenience init (latitude: Double, longitude: Double){
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
