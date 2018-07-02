//
//  Ticker.swift
//  Ticker
//
//  Created by Martin Calvert on 6/11/18.
//  Copyright © 2018 Martin Calvert. All rights reserved.
//

import Foundation

class Ticker: Codable {
    var date: Date
    var name: String
    
    static let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
    
    var timeTill: String {
        let now = Date()
        return date.offset(from: now, withString: "until")
    }
    
    init(date: Date, name: String) {
        self.date = date
        self.name = name
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var dateString: String {
        return Ticker.dateFormatter.string(from: date)
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Ticker.self, from: json) {
            self.date = newValue.date
            self.name = newValue.name
        } else {
            return nil
        }
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date, withString: String) -> String {
        if seconds(from: date) < 0 { return date.offset(from: self, withString: "since")   }
        if days(from: date)    > 0 {
            let tempDays = days(from: date)
            return tempDays > 1 ? "\(days(from: date)) days \(withString)" : "\(days(from: date)) day \(withString)"
        }
        if hours(from: date)   > 0 {
            let tempHours = hours(from: date)
            return tempHours > 1 ? "\(tempHours) hours \(withString)" : "\(tempHours) hour \(withString)"
        }
        if minutes(from: date) > 0 {
            let tempMinutes = minutes(from: date)
            return tempMinutes > 1 ? "\(tempMinutes) minutes \(withString)" : "\(tempMinutes) minute \(withString)"
        }
        if seconds(from: date) > 0 {
            let tempSeconds = seconds(from: date)
            return tempSeconds > 1 ? "\(tempSeconds) seconds \(withString)" : "\(tempSeconds) second \(withString)"
        }
        return ""
    }
}
