import SwiftUI
import Foundation

//  Model

struct Records: Codable {
    let records: [Schedule]?
}

struct Schedule : Codable{
    let id: String
    let fields : Fields
}

struct Fields: Codable{
    let end, activity, type: String
    let speakerS: [String]?
    let start, location: String
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
    func getFurnitureList(callback: @escaping ((errorType: CustomError?,errorMessage: String?), [Schedule]?) -> Void)
    //func deleteFurniture(with id: String, callback: @escaping ((errorType:CustomError?, errorMessage: String?), Response?) -> Void)
}


let url = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule?maxRecords=3&view=Full%20schedule"


class RequestFactory : RequestFactoryProtocol {
    internal func createRequest(urlStr: String, requestType: RequestType,
                                params: [String]?) -> URLRequest {
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
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField:
                            "Authorization")
        return request
    }
    func getFurnitureList(callback: @escaping ((errorType: CustomError?,
                                                errorMessage: String?), [Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
        let furnitureUrlStr = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule" // my modification
        let task = session.dataTask(with: createRequest(urlStr:furnitureUrlStr,requestType: .get,params: nil)) {(data, response, error) in
            if let data = data, error == nil {
                print(data.description)
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        //rint(data, "lllllllllllllllllllllll")
                        print("oooooooooooooooooooooooo")
                        if let response = try?JSONDecoder().decode(Records.self, from: data) {
                            callback((nil, nil), response.records)
                            print(data, "lllllllllllllllllllllll")
                            //print("sssssssssssssssssss")
                        }
                        else{
                            callback((CustomError.parsingError, "parsingerror"), nil)
                            print(responseHttp.statusCode, "responseHttp statusCode \n")
                            //print("sssssssssssssssssss")
                            //print(response!)
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
        task.resume()
        print("the end")
        //print(task, "llllllllllllllllll")
    }
    
}

let requestFactory = RequestFactory()
requestFactory.getFurnitureList { (errorHandle, furnitures) in
    if let _ = errorHandle.errorType, let errorMessage =
        errorHandle.errorMessage {
        print(errorMessage, "I get a parsing error \n")
    }
    else if let list = furnitures, let furniture = list.last {
        print(list.count)
        print(furniture.id)
        print(furniture.fields)
        print("I got something")
    }
    if let list = furnitures {
        for x in furnitures! {
            //print(x.id)
            print(x.fields.activity)
            print(x.fields.start)
            print("\n")
            //print("I got something")
        }
    }
    
    else {
        print("Houston we got a problem")
        } }


let str = "2019-08-12T10:34:05.000Z"
let formatter = DateFormatter()
formatter.locale = Locale(identifier: "en_US_POSIX")
formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
if let date = formatter.date(from: str) {
    formatter.dateFormat = "hh:mm:ss a"
    let timeStr = formatter.string(from: date)
    print(timeStr) //add timeStr to your timeLabel here...

    formatter.dateFormat = "yyyy-MM-dd"
    let dateStr = formatter.string(from: date)
    print(dateStr) //add dateStr to your dateLabel here...
    
    formatter.dateFormat = "yyyy-MM-dd"
    let dateStr1 = formatter.string(from: date)
    print(dateStr1) //add dateStr to your dateLabel here...
}

func isToday(str : String, ourdate : String) -> Bool{
    var cond:Bool
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "fr_FR")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = formatter.date(from: str)
    formatter.dateFormat = "yyyy-MM-dd"
    let dateStr = formatter.string(from: date!)
    if dateStr != ourdate{
        cond = false
    }
    else{
        cond = true
    }
    return cond
}


struct dataFormatter {
    func createFormatter(str : String) -> String{
        let time: String
        let date: String
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let rez = formatter.date(from: str) {
            formatter.dateFormat = "hh:mm:ss a"
            time = formatter.string(from: rez)
            //print(time) //add timeStr to your timeLabel here...

            formatter.dateFormat = "yyyy-MM-dd"
            date = formatter.string(from: rez)
            //print(date) //add dateStr to your dateLabel here...
            let res = date + " " + time
            return res
            }
        else{
            return "something"
        }
    }
        
}


