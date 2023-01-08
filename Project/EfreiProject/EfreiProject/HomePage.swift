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
            VStack{
                HStack{
                    Text("Events Day1")
                        .frame(alignment: .topLeading)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.bottom, 20)
                        .position(x: 100, y: 50)
                    NavigationLink(destination: ListView(info : info)){
                        Text("Event Schedule")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    }
                }
                HStack{
                    List{
                        ForEach(info, id: \.self) { information in
                            if information.fields.start.contains("2023-02-08"){
                                Text("\(information.fields.start)\n\(information.fields.activity)").layoutPriority(10)
                            }
                        }
                    }.position(x:UIScreen.main.bounds.size.width/2, y:  (UIScreen.main.bounds.size.height/3))
                }.frame(minHeight: UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height/4)
            }
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
