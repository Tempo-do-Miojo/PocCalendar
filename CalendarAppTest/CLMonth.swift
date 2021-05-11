//
//  CLMonth.swift
//  CalendarAppTest
//
//  Created by PATRICIA S SIQUEIRA on 10/05/21.
//

import SwiftUI

struct CLMonth: View {

    @Binding var isPresented: Bool
    @ObservedObject var clManager: CLManager

    let monthOffset: Int
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    let daysPerWeek = 7
    var monthsArray: [[Date]] {
        monthArray()
    }
    let cellWidth = CGFloat(32)

    @State var showTime = false

    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10){
            Text(getMonthHeader())
            VStack(alignment: .leading, spacing: 5) {
                    ForEach(monthsArray, id: \.self) { row in
                        HStack() {
                            ForEach(row, id: \.self) { column in
                                HStack() {
                                    Spacer()
                                    if self.isThisMonth(date: column) {
                                        CLCell(clDate: CLDate(
                                            date: column,
                                            clManager: self.clManager,
                                            isToday: self.isToday(date: column),
                                            isSelected: self.isSpecialDate(date: column)
                                        ),
                                        cellWidth: self.cellWidth)
                                        .onTapGesture { self.dateTapped(date: column) }
                                    } else {
                                        Text("").frame(width: self.cellWidth, height: self.cellWidth)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
            }
        }
    }

    func isThisMonth(date: Date) -> Bool {
        return self.clManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
    }

    func dateTapped(date: Date) {
        if self.clManager.selectedDate != nil &&
            self.clManager.calendar.isDate(self.clManager.selectedDate, inSameDayAs: date) {
            //self.clManager.selectedDate = nil
        } else {
            self.clManager.selectedDate = date
        }
        self.isPresented = false
    }

    func monthArray() -> [[Date]] {
        var rowArray = [[Date]]()
        for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
            var columnArray = [Date]()
            for column in 0 ... 6 {
                let abc = self.getDateAtIndex(index: (row * 7) + column)
                columnArray.append(abc)
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }

    func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = clManager.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: clManager.calendar.locale)

        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }

    func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthForOffset()
        let weekday = clManager.calendar.component(.weekday, from: firstOfMonth)
        var startOffset = weekday - clManager.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek
        var dateComponents = DateComponents()
        dateComponents.day = index - startOffset

        return clManager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
    }

    func numberOfDays(offset : Int) -> Int {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = clManager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)

        return (rangeOfWeeks?.count)! * daysPerWeek
    }

    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset

        return clManager.calendar.date(byAdding: offset, to: CLFirstDateMonth())!
    }

    func CLFormatDate(date: Date) -> Date {
        let components = clManager.calendar.dateComponents(calendarUnitYMD, from: date)

        return clManager.calendar.date(from: components)!
    }

    func CLFormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = CLFormatDate(date: referenceDate)
        let clampedDate = CLFormatDate(date: date)
        return refDate == clampedDate
    }

    func CLFirstDateMonth() -> Date {
        var components = clManager.calendar.dateComponents(calendarUnitYMD, from: clManager.minimumDate)
        components.day = 1

        return clManager.calendar.date(from: components)!
    }


    func isToday(date: Date) -> Bool {
        return CLFormatAndCompareDate(date: date, referenceDate: Date())
    }

    func isSpecialDate(date: Date) -> Bool {
        return isSelectedDate(date: date)
    }

    func isSelectedDate(date: Date) -> Bool {
        if clManager.selectedDate == nil {
            return false
        }
        return CLFormatAndCompareDate(date: date, referenceDate: clManager.selectedDate)
    }
}
