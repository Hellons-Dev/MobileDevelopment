//
//  ContentView.swift
//  EfreiProject
//
//  Created by user231584 on 12/12/22.
//

import SwiftUI

struct HomePage: View {
    
    var info : [Schedule]
    
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading) {
                NavigationView {
                    NavigationLink(destination: ListView(info : info)){
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
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(info : [Schedule]())
    }
}
