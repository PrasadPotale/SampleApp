//
//  NewHTTPRequest.swift
//  MyCitySRCloseoutApp
//
//  Created by Piyush on 28/07/17.
//  Copyright © 2017 Kahuna. All rights reserved.
//

import UIKit
import Alamofire

struct APIResponse {
    var jsonObject: AnyObject?
    var errorObject: Error?
    var path: String
}

struct APITimeIntervals {
    var startTime = String()
    var receiveTime = String()
    var parseTime = String()
    var requestInTime = String()
    var requestOutTime = String()
}

class HTTPRequestBlock {

    static let sharedInstance = HTTPRequestBlock()
    var alamofireManager = Alamofire.SessionManager.default
    typealias CompletionBlock = (APIResponse) -> Void

    init() {
    }

    struct APIManager {
        static let sharedManager = { () -> SessionManager in
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(Constants.timeoutInterval.maxTimout)
            configuration.timeoutIntervalForResource = TimeInterval(Constants.timeoutInterval.maxTimout)
            return SessionManager(configuration: configuration)
        }()
    }

    // MARK: - Get Request Object
    func getRequestObjectWith(methodType: HTTPMethod, path: String, contentType: String, timeInterval: Int, parameters: Parameters?) -> (request: URLRequest?, requestString: String, error: NSError?) {

        var requestString = ""
        var jsonData: Data?
        var errorData: NSError!
        if parameters != nil {
            do {
                jsonData = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonRequest = self.parseData(jsonData: jsonData!)
                requestString = jsonRequest
            } catch let error as NSError {
                print(error)
                errorData = error
            }
        }
        if let url = URL(string: path) {
            var request = URLRequest(url: url)
            request.httpMethod = methodType.rawValue
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = TimeInterval(timeInterval)
            if jsonData != nil {
                request.httpBody = jsonData
            }
            // Get Session Token
//            let tokenToSet = self.getSessionToken(path: path)
//            let authheader = [ "Authorization": tokenToSet]

            //request.allHTTPHeaderFields = authheader
            return (request, requestString, errorData)
        }
        return (nil, requestString, errorData)
    }

    // MARK: - POST Method
    func callPOSTRequestAPI( path: String, andParameters parameters: [String: AnyObject]?, timeout: Int, completionHandler: @escaping CompletionBlock) {

        let requestStartTime = Utils.getCurrentDateWithTimeZone(isTimeZone: false)

        // Get Request Object
        let requestResponse = self.getRequestObjectWith(methodType: .post, path: path, contentType: "application/json", timeInterval: timeout, parameters: parameters)
        guard requestResponse.request != nil else {
            completionHandler(APIResponse(jsonObject: nil, errorObject: requestResponse.error, path: path))
            return
        }
        let requestString = "Request : \(requestResponse.requestString)"
        // Get Request Object
        if let request = requestResponse.request {
            APIManager.sharedManager.request(request).responseJSON { response in
                let apiResounse = self.checkResponse(response: response, startTime: requestStartTime, ulr: path, request: requestString)
                completionHandler(apiResounse)
            }
        }
    }

    // MARK: - GET Method
    func callGETRequestAPI( path: String, timeout: Int, completionHandler: @escaping CompletionBlock) {

        let requestStartTime = Utils.getCurrentDateWithTimeZone(isTimeZone: false)
        let requestResponse = self.getRequestObjectWith(methodType: .get, path: path, contentType: "text/plain", timeInterval: timeout, parameters: nil)
        guard requestResponse.request != nil else {
            completionHandler(APIResponse(jsonObject: nil, errorObject: requestResponse.error, path: path))
            return
        }

        if let request = requestResponse.request {
            APIManager.sharedManager.request(request).responseJSON { response in
                // This is specific for VAP Geocoding api
                let apiResounse = self.checkResponse(response: response, startTime: requestStartTime, ulr: path, request: "")
                completionHandler(apiResounse)
            }
        }
    }

    // MARK: - MULTIPART Method
    func callMultipartRequestAPI( _ path: String, withImagePaths imagePaths: [String], andParameters parameters: [String: AnyObject]?, timeout: Int, completionHandler: @escaping CompletionBlock) {

        let requestStartTime = Utils.getCurrentDateWithTimeZone(isTimeZone: false)
        // Get Request Object
        let requestResponse = self.getRequestObjectWith(methodType: .post, path: path, contentType: "application/json", timeInterval: timeout, parameters: parameters)
        guard requestResponse.request != nil else {
            completionHandler(APIResponse(jsonObject: nil, errorObject: requestResponse.error, path: path))
            return
        }
        // Get Request Object
        let requestString = "Request : \(requestResponse.requestString)"
        let jsonRequest = requestResponse.requestString

        if let request = requestResponse.request {
            APIManager.sharedManager.upload(multipartFormData: { (multipartFormData) in
                var i = 1
                for imagePath in imagePaths {
                    i = i + 1
                    let imageKey = "image" + String(i)
                    multipartFormData.append(URL(fileURLWithPath: imagePath), withName: imageKey)
                }
                multipartFormData.append(jsonRequest.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "data")
            }, with: request, encodingCompletion: { (result) in
                switch result {
                case .failure(let encodingError):
                    completionHandler(APIResponse(jsonObject: nil, errorObject: encodingError, path: path))
                    break
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let apiResounse = self.checkResponse(response: response, startTime: requestStartTime, ulr: path, request: requestString)
                        completionHandler(apiResounse)
                    }
                    break
                }
            })
        }
    }

    func parseData(jsonData: Data) -> String {
        let str = String(data: jsonData, encoding: .utf8)
        return str!
    }

    // MARK: - Check Response Format
    func checkResponse(response: DataResponse<Any>, startTime: String, ulr path: String, request: String) -> APIResponse {

        let errorHdlr = ErrorCodesHandler()

        // Response Recieve Time
        let responseReceiveTime = Utils.getCurrentDateWithTimeZone(isTimeZone: false)
        let responseString = "\n\nResponse : \(self.parseData(jsonData: response.data!))\n\n"
        print("\nPath :\(path) \n \(request)\n\(responseString)\n")

        var apiObject: APIResponse?
        var deviceLogErrorCode = ServerErrorCodes.successCode
        var deviceLogResponse = ""
        // 1. Check if there is error in response
        if let error = response.error {
            apiObject = APIResponse(jsonObject: nil, errorObject: error, path: path)
            deviceLogErrorCode = error._code
            deviceLogResponse = error.localizedDescription
        } else if response.data == nil {
            // 2. Now Check if response data is nil
            let errorObject = errorHdlr.getErrorObjectWith(title: "Response is nil", message: nil, errorCode: IOSErrorCodes.emptyHttpResponse)
            apiObject = APIResponse(jsonObject: nil, errorObject: errorObject, path: path)
            deviceLogErrorCode = IOSErrorCodes.unknownError
            deviceLogResponse = "Response is nil"
        } else {
            // 3. Now we have recieved Response
            let responseData = response.data!
            // a. We have to parse response to check if it is proper
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions(rawValue: 0))
                // Response parse time
                let responseParseTime = Utils.getCurrentDateWithTimeZone(isTimeZone: false)
                var status = "Failure"
                let checkReponseData: CheckResponseFormat = CheckResponseFormat(fromDictionary: (jsonObject as? NSDictionary)!)
                // b. Now we have to check if obtained response Result is nil
                if checkReponseData.result == nil {
                    deviceLogErrorCode = IOSErrorCodes.responseResultEmpty
                    deviceLogResponse = responseString
                    let errorObject = errorHdlr.getErrorObjectWith(title: nil, message: nil, errorCode: IOSErrorCodes.responseResultEmpty)
                    apiObject = APIResponse(jsonObject: nil, errorObject: errorObject, path: path)
                } else if checkReponseData.result.code != ServerErrorCodes.successCode {
                    // c. Check if Response result code is not requals to Success Code
                    if checkReponseData.result.code == ServerErrorCodes.sessionExpireErrorCode {
                        // c1. Sesssion expire check
//                        let errorObject = errorHdlr.getErrorObjectWith(title: nil, message: nil, errorCode: ServerErrorCodes.sessionExpireErrorCode)
//                        errorHdlr.showErrorWhenServerResponded(error: errorObject)
                    }
                    deviceLogErrorCode = checkReponseData.result.code
                    deviceLogResponse = responseString
                    let errorObject = errorHdlr.getErrorObjectWith(title: nil, message: nil, errorCode: deviceLogErrorCode)
                    //errorHdlr.showErrorWhenServerResponded(error: errorObject)
                    apiObject = APIResponse(jsonObject: nil, errorObject: errorObject, path: path)
                } else {
                    apiObject = APIResponse(jsonObject: jsonObject as AnyObject, errorObject: nil, path: path)
                }
                // d. We have to send time interval to Logcamp server
                let timeInterval = APITimeIntervals(startTime: startTime, receiveTime: responseReceiveTime, parseTime: responseParseTime, requestInTime: "", requestOutTime: "")
                if checkReponseData.result?.code == ServerErrorCodes.successCode {
                    status = "Success"
                }
                self.sendTimeStampLogsToServer(path, responseStatus: status, timeIntervals: timeInterval)
            }
            catch let JSONError as NSError {
                apiObject = APIResponse(jsonObject: nil, errorObject: JSONError, path: path)
            }
        }
        /** SEND LOGS TO SERVER IF ERROR CODE IS NOT 200 */
        if deviceLogErrorCode != ServerErrorCodes.successCode {
            self.sendDeviceLogsToServer(request, with: deviceLogResponse, urlPath: path, erroCode: Double(deviceLogErrorCode))
        }
        return apiObject!
    }

    // MARK: - SEND TIME STAMP VALUES TO KAHUNA SERVER
    func sendTimeStampLogsToServer(path: String, responseStatus: String, jsonObject: AnyObject, apiTimeIntervals: APITimeIntervals) {

        // SEND TIME STAMP VALUES TO KAHUNA SERVER
        if jsonObject is NSDictionary {
            let jsonObjectDict = jsonObject as? NSDictionary
            var requestInTime = Utils.getCurrentDateWithTimeZone(isTimeZone: false)
            var requestOutTime = Utils.getCurrentDateWithTimeZone(isTimeZone: false)
            if let time = jsonObjectDict?["requestInTime"] {
                requestInTime = String(format: "%@", (time as? String)!) // time as! String
            }
            if let otime = jsonObjectDict?["requestOutTime"] {
                requestOutTime = String(format: "%@", (otime as? String)!)
            }
            var timeIntvl = apiTimeIntervals
            timeIntvl.requestInTime = requestInTime
            timeIntvl.requestOutTime = requestOutTime
            self.sendTimeStampLogsToServer(path, responseStatus: responseStatus, timeIntervals: timeIntvl)
        }
    }

    // MARK:- Send Error Logs to server
    func sendDeviceLogsToServer(_ request: String?, with response: String?, urlPath: String, erroCode: Double) {

        // we dont have to send simulator logs
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return
        #else
            // We dont have to send request where there is user password
            /*var requestToSend = request
            if urlPath.contains(Constants.ServiceEndPoints.loginUser) {
                requestToSend = ""
            }
            let userDefault = UserDefaults.standard
            var username = ""
            if userDefault.value(forKey: Constants.UniqueKeyConstants.LoginUsername) != nil {
                username = (userDefault.value(forKey: Constants.UniqueKeyConstants.LoginUsername) as? String)!
            }*/
//            KALogger.sendDeviceLogsToServer(withRequest: requestToSend, withResponse: response, urlPath: urlPath, userName: username, errorCode: NSNumber(value: erroCode as Double))
        #endif
    }

    // MARK:- Send Time Stamps to server
    func sendTimeStampLogsToServer(_ serviceType: String, responseStatus: String, timeIntervals: APITimeIntervals) {
//        KALogger.sendTimeStampLogsToServer(forServiceType: serviceType, responseStatus: responseStatus, mobileRequestStartTime: timeIntervals.startTime, mobileResponseReceiveTime: timeIntervals.receiveTime, mobileServiceParseTime: timeIntervals.parseTime, serverRequestReceiveTime: timeIntervals.requestInTime, serverResponseStartTime: timeIntervals.requestOutTime)
    }

}
