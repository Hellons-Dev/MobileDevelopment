import SwiftUI

struct ListView: View {
    //@StateObject var requ = RequestFactory()
    //var schedule: Schedule = Schedule()
    
    var req : RequestFactory
    
    var body: some View {
        
        NavigationView{
            List(req.schedules, id: \.self) { schedule in
                
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
        ListView(req: RequestFactory())
    }
}
