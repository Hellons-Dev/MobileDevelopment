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
                } else if isDataErr(info: requ) {
                    Text("Error, Data unavailable\nPlease try again later").font(.largeTitle)
                        .position(x:UIScreen.main.bounds.size.width/2 ,y:UIScreen.main.bounds.size.height/2-40)
                        .padding()
                } else if isNetErr(info: requ) {
                    Text("Error, Could not reach database\nPlease check your internet connexion").font(.largeTitle)
                        .position(x:UIScreen.main.bounds.size.width/2 ,y:UIScreen.main.bounds.size.height/2-40)
                        .padding()
                } else if isParsErr(info: requ) {
                    Text("Error, There might be a problem with your application\nPlease check for update or try reinstalling it").font(.largeTitle)
                        .position(x:UIScreen.main.bounds.size.width/2 ,y:UIScreen.main.bounds.size.height/2-40)
                        .padding()
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

func isDataErr(info : RequestFactory) -> Bool{
    
    if info.dataError == true {
        
        return true
    }
    return false
}

func isNetErr(info : RequestFactory) -> Bool{
    
    if info.netError == true {
        
        return true
    }
    return false
}

func isParsErr(info : RequestFactory) -> Bool{
    
    if info.parsingError == true {
        
        return true
    }
    return false
}
