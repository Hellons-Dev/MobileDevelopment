//
//  InformationGetterScript.swift
//  EfreiProject
//
//  Created by user231584 on 12/21/22.
//

import Foundation
import UIKit
import SwiftUI

struct Persons: Codable {
    let name : String
    let company : String
    let role : String
    let email : String
    let phone : String
}

struct Speakers: Codable {
    let speakers : Persons
}

struct Attendees: Codable {
    let attendees : Persons
}

struct Events : Codable {
    let activity : String
    let type : String
    let start : Date
    let end : Int
    let location : String
    let speakers : [Speakers]
}

let Belinda = Speakers(speakers: Persons(name: "Belinda Chen", company: "Home SecurTech", role: "Product Manager", email: "belinda@email.com", phone: "(123) 456-7890"))

struct InformationGetterScript: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(String(decoding: Belinda, as: UTF8.self))
        }
        .padding()
    }
}

struct InformationGetterScript_Preview: PreviewProvider {
    static var previews: some View {
        InformationGetterScript()
    }
}
