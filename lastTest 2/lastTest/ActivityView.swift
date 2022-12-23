//
//  ActivityView.swift
//  lastTest
//
//  Created by user232280 on 12/23/22.
//

import SwiftUI

struct ActivityView: View {
    var activity : Schedule
    var body: some View {
        VStack{
            Text(activity.fields.activity)
            Text(activity.fields.type)
            Text(activity.fields.start)
            Text(activity.fields.end)
            /*VStack{ // this Vstack is supposed to display the the speakers, but I can't make it work
                ForEach(activity.fields.speakerS!){ x in
                    Text(x)
                }
            }*/
            Text(activity.fields.notes ?? "no notes")
            Text(activity.fields.location)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity : Schedule(id :"99", fields: Fields(end: "12 p.m", activity: "Maths", type: "Course", speakerS: ["Moise, Adams"], start: "monday 9 a.m", location: "Efrei", notes: "something")))
    }
}
