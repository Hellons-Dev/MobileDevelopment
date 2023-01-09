//
//  ContentView.swift
//  EfreiProject
//
//  Created by user231584 on 12/12/22.
//

import SwiftUI

struct LoadingView: View {
    
    @StateObject var requ = RequestFactory()
    
    var body: some View {
        
        NavigationView{
            VStack{
                if isReady(info: requ) {
                    HomePage(info: requ.schedules)
                } else {
                    Text("Loading").font(.largeTitle)
                        .position(x:UIScreen.main.bounds.size.width/2 ,y:UIScreen.main.bounds.size.height/2-40)
                        .padding()
                        .onAppear{
                            requ.getSchedule { (errorHandle, schedules) in}
                        }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

func isReady(info : RequestFactory) -> Bool{
    
    if info.ready == true {
        
        return true
    }
    return false
}
