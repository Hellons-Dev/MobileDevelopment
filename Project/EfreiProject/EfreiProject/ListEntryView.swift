import SwiftUI

struct ListEntryView: View {
    var schedule: Schedule
    
    var body: some View {
        HStack {
            Text(schedule.fields.activity)
        }
    }
}

struct ListEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ListEntryView(schedule : Schedule(id :"99", fields: Fields(end: "12 p.m", activity: "Maths", type: "Course", speakerS: ["Moise, Adams"], start: "monday 9 a.m", location: "Efrei", notes: "something")))
    }
}
