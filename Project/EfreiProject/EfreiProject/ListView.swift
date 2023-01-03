import SwiftUI

struct ListView: View {
    @StateObject var requ = RequestFactory()
    //var schedule: Schedule = Schedule()
    var body: some View {
        NavigationView{
            List(requ.schedules, id: \.self) { schedule in
                
                    NavigationLink(destination: EventView(activity: schedule)){
                        ListEntryView(schedule: schedule)
                    }
                }
            .navigationTitle("Schedule")
            .onAppear{
                requ.getSchedule { (errorHandle, schedules) in}
            }
            }
        }
    }


struct NListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
