//
//  ContentView.swift
//  CalendarAppTest
//
//  Created by PATRICIA S SIQUEIRA on 10/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var sheetPresented = false
    
    @ObservedObject var clManagerX = CLManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365))
    
    var body: some View {
        VStack(spacing: 15) {
            Button(action: {self.sheetPresented.toggle()}) {
                Text("Check calendar")
            }
            .font(.largeTitle)
            .sheet(isPresented: self.$sheetPresented, content: {
                CLViewController(isPresented: self.$sheetPresented, clManager: self.clManagerX)})
            Text(self.getTextFromDate(date: self.clManagerX.selectedDate))
                .font(.largeTitle)
        }
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM-dd-YYYY"
        return date == nil ? "é isso" : formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


