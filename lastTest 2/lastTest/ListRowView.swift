//
//  ListRowView.swift
//  lastTest
//
//  Created by user232280 on 12/23/22.
//

import SwiftUI

struct ListRowView: View {
    var schedule: Schedule
    
    var body: some View {
        HStack {
            Text(schedule.fields.activity)
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(schedule : Schedule(id :"99", fields: Fields(end: "12 p.m", activity: "Maths", type: "Course", speakerS: ["Moise, Adams"], start: "monday 9 a.m", location: "Efrei", notes: "something")))
    }
}
