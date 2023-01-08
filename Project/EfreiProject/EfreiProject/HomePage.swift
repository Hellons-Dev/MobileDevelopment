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
        NavigationView {
            HStack(alignment: .top){
                Text("Day1")
                    .frame(alignment: .topLeading)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                List{
                    ForEach(info, id: \.self) { information in
                        if information.fields.start.contains("2023-02-08"){
                            Text("\(information.fields.start)\n\(information.fields.activity)").padding(.leading)
                        }
                    }
                }
                NavigationLink(destination: ListView(info : info)){
                    Text("Event Schedule")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                }
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
}
