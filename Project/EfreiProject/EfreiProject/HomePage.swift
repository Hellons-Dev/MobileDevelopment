//
//  ContentView.swift
//  EfreiProject
//
//  Created by user231584 on 12/12/22.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Event of the day:")
        }
        .padding()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
