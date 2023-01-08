import SwiftUI
import Foundation

//  Model

struct Records: Codable {
    let records: [Schedule]?
}

struct Schedule : Codable, Hashable{
    let id: String
    var fields : Fields
}

struct Fields: Codable, Hashable{
    var end, activity, type: String
    let speakerS: [String]?
    var start, location: String
    let notes: String?

    enum CodingKeys: String, CodingKey {
        case end = "End"
        case activity = "Activity"
        case type = "Type"
        case speakerS = "Speaker(s)"
        case start = "Start"
        case location = "Location"
        case notes = "Notes"
    }
}

struct Response: Codable{
    let id : String
    let deleted : Bool
}
struct ErrorResponse: Codable{
    let error : String
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
    func getSchedule(callback: @escaping ((errorType: CustomError?,errorMessage: String?), [Schedule]?) -> Void)
    
}





class RequestFactory : RequestFactoryProtocol, ObservableObject {
    @Published var schedules : [Schedule] = []
    @Published var ready : Bool = false
    
    internal func createRequest(urlStr: String, requestType: RequestType,params: [String]?) -> URLRequest {
        var url: URL = URL(string: urlStr)!
        if let params = params {
            var urlParams = urlStr
            for param in params {
                urlParams = urlParams + "/" + param
            }
            url = URL(string: urlParams)!
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 100
        request.httpMethod = requestType.rawValue
        let accessToken = "keymaCPSexfxC2hF9"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField:
                            "Authorization")
        return request
    }
    func getSchedule(callback: @escaping ((errorType: CustomError?,
                                                errorMessage: String?), [Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
        let scheduleUrlString = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule" // my modification
        
        let task = session.dataTask(with: createRequest(urlStr:scheduleUrlString,requestType: .get,params: nil)) {(data, response, error) in
            if let data = data, error == nil {
                print(data.description)
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        let group = DispatchGroup()
                        group.enter()
                        if let response = try?JSONDecoder().decode(Records.self, from: data) {
                            callback((nil, nil), response.records)
                            var tempList : [Schedule] = []
                            DispatchQueue.main.async {
                                self.schedules = response.records!
                                tempList = self.schedules
                                group.leave()
                                self.ready = true
                            }
                            group.wait()
                            
                            var i = 0
                            for entry in tempList {
                                group.enter()
                                DispatchQueue.main.async {
                                    var time : String
                                    var date : String
                                    let formatter = DateFormatter()
                                    formatter.locale = Locale(identifier: "fr_FR")
                                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                                    i = i+1
                                    if let reformator = formatter.date(from: entry.fields.start){
                                        formatter.dateFormat = "hh:mm:ss a"
                                        time = formatter.string(from: reformator)
                                        formatter.dateFormat = "yyyy-MM-dd"
                                        date = formatter.string(from: reformator)
                                        
                                        tempList[i-1].fields.start = date + " " + time
                                    }
                                    //print(tempList[i-1].fields.start)
                                    
                                    group.leave()
                                }
                                group.wait()
                            }
                            i=0
                            for entry in tempList {
                                group.enter()
                                DispatchQueue.main.async {
                                    var time : String
                                    var date : String
                                    let formatter = DateFormatter()
                                    formatter.locale = Locale(identifier: "fr_FR")
                                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                                    i = i+1
                                    if let reformator = formatter.date(from: entry.fields.end){
                                        formatter.dateFormat = "hh:mm:ss a"
                                        time = formatter.string(from: reformator)
                                        formatter.dateFormat = "yyyy-MM-dd"
                                        date = formatter.string(from: reformator)
                                        
                                        tempList[i-1].fields.end = date + " " + time
                                    }
                                    //print(tempList[i-1].fields.start)
                                    
                                    group.leave()
                                }
                                group.wait()
                            }
                            var sorted = false
                            //while sorted != true {
                                i=0
                                for entry in tempList{
                                    group.enter()
                                    DispatchQueue.main.async {
                                        group.leave()
                                    }
                                    group.wait()
                                }
                            //}
                            group.enter()
                            DispatchQueue.main.async {
                                //print(tempList[5].fields.start)
                                //print(tempList[5].fields.end)
                                self.schedules = tempList
                                group.leave()
                                self.ready = true
                            }
                            group.wait()
                            
                        }
                        else{
                            callback((CustomError.parsingError, "parsingerror"), nil)
                            print(responseHttp.statusCode, "responseHttp statusCode \n")
                        }
                    }
                    else{
                        callback((CustomError.statusCodeError, "statuscode: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else{
                callback((CustomError.requestError,error.debugDescription), nil)
            }
        }
        //self.dateFormatingAndSorting(info: self.schedules)
        task.resume()
        
    }
    
    func fetch(){
        let requestFactory = RequestFactory()
        requestFactory.getSchedule { (errorHandle, events) in
            if let list = events, let event = list.last {
                //print(type(of: list))
                //print(list.count)
                Text(event.id)
                //print(furniture.fields)
                //print("I got something")
            }
        }
    }
    
    func dateFormatingAndSorting(){
        var tempList : [Schedule] = self.schedules
        
        print(tempList[5].fields.start)
        print(tempList[5].fields.end)
        
        var time : String
        var date : String
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var i = 0
        for currentDate in tempList {
            i = i+1
            if let reformatorStart = formatter.date(from: currentDate.fields.start){
                formatter.dateFormat = "hh:mm:ss a"
                time = formatter.string(from: reformatorStart)
                formatter.dateFormat = "yyyy-MM-dd"
                date = formatter.string(from: reformatorStart)
                
                tempList[i-1].fields.start = date + " " + time
            }
            if let reformatorEnd = formatter.date(from: currentDate.fields.end){
                formatter.dateFormat = "hh:mm:ss a"
                time = formatter.string(from: reformatorEnd)
                formatter.dateFormat = "yyyy-MM-dd"
                date = formatter.string(from: reformatorEnd)
                
                tempList[i-1].fields.end = date + " " + time
                
            }
        }
        
        print(tempList[5].fields.start)
        print(tempList[5].fields.end)
        self.schedules = tempList
    }
}
