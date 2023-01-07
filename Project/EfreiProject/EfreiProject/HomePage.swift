//
//  ContentView.swift
//  EfreiProject
//
//  Created by user231584 on 12/12/22.
//

import SwiftUI

struct HomePage: View {
    
    @StateObject var requ = RequestFactory()
    
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading) {
                NavigationView {
                    NavigationLink(destination: ListView(req: requ)){
                        Text("Event Schedule")
                    }
                }
            }
        }
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Event of the day:")
            
        }
        .padding()
        .onAppear{
            requ.getSchedule { (errorHandle, schedules) in}
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
