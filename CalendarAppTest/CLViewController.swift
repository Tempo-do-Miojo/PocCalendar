//
//  CLViewController.swift
//  CalendarAppTest
//
//  Created by PATRICIA S SIQUEIRA on 10/05/21.
//

import SwiftUI

struct CLViewController: View {
    @Binding var isPresented: Bool
    @ObservedObject var clManager: CLManager
    
    var body: some View {
        Group{
            List {
                ForEach(0..<numberOfMonths()) { index in
                    CLMonth(isPresented: self.$isPresented, clManager: self.clManager, monthOffset: index)
                }
                Divider()
            }
        }
    }
    
    func numberOfMonths() -> Int {
        return clManager.calendar.dateComponents([.month], from: clManager.minimumDate, to: CLMaximumDateMonthLastDay()).month! + 1
    }
    
    func CLMaximumDateMonthLastDay() -> Date {
        var components = clManager.calendar.dateComponents([.year, .month, .day], from: clManager.maximumDate)
        components.month! += 1
        components.day = 0
        return clManager.calendar.date(from: components)!
    }
    
}
