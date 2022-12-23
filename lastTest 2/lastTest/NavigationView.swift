//
//  NavigationView.swift
//  lastTest
//
//  Created by user232280 on 12/23/22.
//

import SwiftUI

struct NavigationViews: View {
    @StateObject var requ = RequestFactory()
    //var schedule: Schedule = Schedule()
    var body: some View {
        NavigationView{
            List(requ.schedules, id: \.self) { schedule in
                
                NavigationLink(destination: ActivityView(activity: schedule)){
                    ListRowView(schedule: schedule)
                }
                }
            .navigationTitle("Schedule")
            .onAppear{
                requ.getFurnitureList { (errorHandle, furnitures) in}
            }
            }
        }
    }


struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViews()
    }
}
