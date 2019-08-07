//
//  Extensions.swift
//  Threads
//
//  Created by Molnár Csaba on 2019. 08. 07..
//  Copyright © 2019. Molnár Csaba. All rights reserved.
//

import Foundation

extension Double {
    func metersToMiles(places: Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
}
