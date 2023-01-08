import SwiftUI

struct ListView: View {
    //@StateObject var requ = RequestFactory()
    //var schedule: Schedule = Schedule()
    
    var info : [Schedule]
    
    var body: some View {
        
        NavigationView{
            List(info, id: \.self) { schedule in
                
                NavigationLink(destination: EventView(activity: schedule)){
                    ListEntryView(schedule: schedule)
                }
            }
            .navigationTitle("Schedule")
        }
    }
}

struct NListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(info : [Schedule]())
    }
}
