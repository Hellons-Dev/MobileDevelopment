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

struct Records: Codable {
    let records : [Events]
}

struct Response: Codable {
    let id: String
    let deleted: Bool
}

struct ErrorResponse: Codable {
    let error: String
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}

// Request Factory
protocol RequestFactoryProtocol {
    func createRequest(urlStr: String, requestType: RequestType, params: [String]?) -> URLRequest
    func getFurnitureList(callback: @escaping ((errorType: CustomError?, errorMessage: String?), [Events]?) -> Void)
}

private let eventUrl = "https://airtable.com/appLxCaCuYWnjaSKB/tblon3PzkaCkPGUnr/viwPg3QwJjoQEsQSQ?blocks=hide"

class RequestFactory: RequestFactoryProtocol {
    internal func createRequest(urlStr: String, requestType: RequestType, params: [String]?) -> URLRequest {
        var url: URL = URL(string: urlStr)!
        if let params = params {
            var urlParams = urlStr
            for param in params {
                urlParams = urlParams + "/" + param
            }
            print(urlParams)
            url = URL(string: urlParams)!
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 100
        request.httpMethod = requestType.rawValue
        let accessToken = "keymaCPSexfxC2hF9"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField:"Authorization")
        return request
    }
    func getFurnitureList(callback: @escaping ((errorType: CustomError?, errorMessage: String?), [Events]?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: eventUrl, requestType: .get, params: nil)) {
            (data, response, error) in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        if let response = try?
                            JSONDecoder().decode(Records.self, from: data) {
                            callback((nil, nil), response.records)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    }
                    else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else {
                callback((CustomError.requestError, error.debugDescription), nil)
            }
        }
        task.resume()
    }
}

// Controller

let requestFactory = RequestFactory()

requestFactory.getFurnitureList {
    (errorHandle, Events) in
    if let _ = errorHandle.errorType, let errorMessage = errorHandle.errorMessage {
        print(errorMessage)
    }
    else if let list = Events, let Events = list.last {
        print(Events.activity)
    }
    else {
        print("Houston we got a problem")
    }
}

struct InformationGetterScript: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("some text")
        }
        .padding()
    }
}

struct InformationGetterScript_Preview: PreviewProvider {
    static var previews: some View {
        InformationGetterScript()
    }
}
