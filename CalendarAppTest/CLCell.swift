//
//  CLCell.swift
//  CalendarAppTest
//
//  Created by PATRICIA S SIQUEIRA on 10/05/21.
//

import SwiftUI

struct CLCell: View {
    
    var clDate: CLDate
    var cellWidth: CGFloat
    
    var body: some View {
        Text(clDate.getText())
            .fontWeight(clDate.getFontWeight())
            .foregroundColor(clDate.getColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 20))
            .cornerRadius(cellWidth/2)
    }
}
