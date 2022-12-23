//
//  ContentView.swift
//  lastTest
//
//  Created by user232280 on 12/18/22.
//

import SwiftUI

struct Test {
    func displaysomthing() -> String{
        return "something"
    }
}

struct ContentView: View {
    @StateObject var req = RequestFactory()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            List{
                ForEach(req.schedules, id: \.self){ x in
                    VStack{
                        Text(x.fields.activity)
                    }
                }
            }
            Text("Hello, world! swift is stupid")
            Text(Test().displaysomthing())
                .onAppear{
                    req.getFurnitureList { (errorHandle, furnitures) in}
                }
           
            

            }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
