//
//  Date+ext.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 10.09.2022.
//

import Foundation

extension Date {
    func isHalfHourBeforeTomorrow(day: Date) -> Bool {
        if Calendar.current.isDate(self, inSameDayAs: day) {
            let hours = Calendar.current.component(.hour, from: self)
            if hours < 23  {
                return false
            }
            let minutes = Calendar.current.component(.minute, from: self)
            return minutes >= 30
        } else {
            return true
        }
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func formattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: self)
    }
    
    func formattedFullDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy hh:mm"
        return dateFormatter.string(from: self)
    }
}
