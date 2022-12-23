import SwiftUI
import Foundation

//  Model

struct Records: Codable {
    let records: [Schedule]?
}

struct Schedule : Codable, Hashable{
    let id: String
    let fields : Fields
}

struct Fields: Codable, Hashable{
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
    
}





class RequestFactory : RequestFactoryProtocol, ObservableObject {
    @Published var schedules : [Schedule] = []
    
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
    func getFurnitureList(callback: @escaping ((errorType: CustomError?,
                                                errorMessage: String?), [Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
        let furnitureUrlStr = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule" // my modification
        let task = session.dataTask(with: createRequest(urlStr:furnitureUrlStr,requestType: .get,params: nil)) {(data, response, error) in
            if let data = data, error == nil {
                print(data.description)
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        
                        if let response = try?JSONDecoder().decode(Records.self, from: data) {
                            callback((nil, nil), response.records)
                            DispatchQueue.main.async {
                                self.schedules = response.records!
                            }
                        
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
        task.resume()

    }
    
    func fetch(){
        let requestFactory = RequestFactory()
        requestFactory.getFurnitureList { (errorHandle, furnitures) in
            if let list = furnitures, let furniture = list.last {
                //print(type(of: list))
                //print(list.count)
                Text(furniture.id)
                //print(furniture.fields)
                //print("I got something")
            }
        }
    }
    
}
