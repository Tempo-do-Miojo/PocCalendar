//
//  CLDate.swift
//  CalendarAppTest
//
//  Created by PATRICIA S SIQUEIRA on 10/05/21.
//

import SwiftUI

struct CLDate {
    
    var date: Date
    let clManager: CLManager
    var isToday: Bool = false
    var isSelected: Bool = false
    
    init(date: Date, clManager: CLManager, isToday: Bool, isSelected: Bool) {
        self.date = date
        self.clManager = clManager
        self.isSelected = isSelected
        self.isToday = isToday
    }
    
    func getText() -> String {
        let day = formatDate(date: date, calendar: self.clManager.calendar)
        return day
    }
    
    func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.medium
        
        if isSelected || isToday {
            fontWeight = Font.Weight.heavy
        }
        
        return fontWeight
    }
    
    func getColor() -> Color? {
        var color = Color.black
        
        if isSelected {
            color = Color.red
        } else if isToday {
            color = Color.black
        } else if date < Date() {
            color = Color.blue
        } else {
            color = Color.yellow
        }
        return color
    }
    
    func formatDate(date: Date, calendar: Calendar) -> String {
        let formatter = dateFormatter()
        return stringFrom(date: date, formatter: formatter, calendar: calendar)
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "dd"
        return formatter
    }
    
    func stringFrom(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {
        if formatter.calendar != calendar {
            formatter.calendar = calendar
        }
        
        return formatter.string(from: date)
    }
}
