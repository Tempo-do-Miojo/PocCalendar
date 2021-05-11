//
//  CLManager.swift
//  CalendarAppTest
//
//  Created by PATRICIA S SIQUEIRA on 10/05/21.
//

import SwiftUI

class CLManager: ObservableObject {
    @Published var calendar = Calendar.current
    @Published var minimumDate:Date = Date()
    @Published var maximumDate:Date = Date()
    @Published var selectedDates: [Date] = [Date]()
    @Published var selectedDate: Date! = nil
    
    init(calendar: Calendar, minimumDate: Date, maximumDate: Date, selectedDates: [Date] = [Date]()) {
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.selectedDates = selectedDates
    }
    
    func selectedDatesContains(date:Date) -> Bool {
        if let _ = self.selectedDates.first(where: { calendar.isDate($0, inSameDayAs: date) }){
            return true
        }
        return false
    }
    
    func selectedDatesFindIndex(date:Date) -> Int? {
        return self.selectedDates.firstIndex(where: { calendar.isDate($0, inSameDayAs: date)})
    }
}
