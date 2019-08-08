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

extension Int {
    func formatTimeDurationToString() -> String {
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durataionSeconds = (self % 3600) % 60
        
        if durataionSeconds < 0 {
            return "00:00:00"
        } else {
            if durationHours == 0 {
                return String(format: "%02d:%02d", durationMinutes, durataionSeconds)
            } else {
                return String(format: "%02d:%02d:%02d", durationHours, durationMinutes, durataionSeconds)
            }
        }
    }
}
extension NSDate{
    func getDateString() -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self as Date)
        let day = calendar.component(.day, from: self as Date)
        let year = calendar.component(.year, from: self as Date)
        
        return "\(month)/\(day)/\(year)"
    }
}




