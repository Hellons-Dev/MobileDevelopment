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
        if isReady(info: requ) {
            
            HomePage(info: requ.schedules)
        }
        VStack(){
            Text("test")
        }
        .padding()
        .onAppear{
            requ.getSchedule { (errorHandle, schedules) in}
        }
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
