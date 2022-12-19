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
    let activity: String
    let type: String?
    let start: String
    let end : String
    let location : String
    let speaker :[String]
    let notes : String
    enum CodingKeys : String, CodingKey {
        case activity = "Activity"
        case type = "Type"
        case start = "Start"
        case end = "End"
        case location = "Location"
        case speaker = "Speaker(s)"
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


let url = "https://airtable.com/appLxCaCuYWnjaSKB/tblon3PzkaCkPGUnr/viwPg3QwJjoQEsQSQ?blocks=hide"


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
        let furnitureUrlStr = "https://airtable.com/appLxCaCuYWnjaSKB/tblon3PzkaCkPGUnr/viwPg3QwJjoQEsQSQ?blocks=hide" // my modification
        let task = session.dataTask(with: createRequest(urlStr:furnitureUrlStr,requestType: .get,params: nil)) {(data, response, error) in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        if let response = try?JSONDecoder().decode(Records.self, from: data) {
                            callback((nil, nil), response.records)
                        }
                        else{
                            callback((CustomError.parsingError, "parsingerror"), nil)
                            print(responseHttp.statusCode, "responseHttp statusCode \n")
                            print(response!)
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
        print(furniture.id)
    }
    else {
        print("Houston we got a problem")
        } }
