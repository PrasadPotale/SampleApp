//
//  ErrorCodesHandler.swift
//  MyCitySRCloseoutApp
//
//  Created by Piyush on 26/06/17.
//  Copyright © 2017 Kahuna. All rights reserved.
//

import UIKit

struct InternalErrorStruct: Error {
    let _domain: String
    let _code: Int
    let _message: String?
}

struct IOSErrorCodes {

    // System Defaults Error Codes
    static let multipleServiceCalls = -999
    static let badURL = -1000
    static let timeout = -1001
    static let unsupportedURL = -1002
    static let cannotFindHost = -1003
    static let cannotConnectToHost = -1004
    static let connectionLost = -1005
    static let dnsLookupFail = -1006
    static let tooManyRedirect = -1007
    static let resourceUnavailable = -1008
    static let notConnectedToInternet = -1009
    static let nonExistantLocationRedirect = -1010
    static let badServerResponse = -1011
    static let connotParseResponse = -1017
    static let internetRoamingOff = -1018
    static let callsActive = -1019
    static let dataNoAllowed = -1020
    static let dataLengthExceeds = -1103

    // This error code we are using when response result gets empty
    static let emptyHttpResponse = -3999
    static let responseResultEmpty = -4000
    static let unknownError = -4001
    // This error code we are using when we dont have to show error code
    static let dontShowErrorCode = -4002
}

struct ServerErrorCodes {

    static let successCode: Int = 200
    static let generalErrorCode = 201
    static let sessionExpireErrorCode = 310
    static let duplicateEntryCode = 203
    static let missingFieldsCode = 2015
    
    static let noRecordFoundSocialUser = 224
    static let emailVerificationPending: Int = 229
    
    static let emailAlreadyExist: Int = 233
    static let generalExceptionCode: Int = 520
    static let invalidGISAddress: Int = 535
    static let invalidCredential: Int = 210
    static let emailNotExist: Int = 301
    static let inappropriateDataCode: Int = 400
    static let socialSignupFieldsEmpty: Int = 548
}

class ErrorCodesHandler: NSObject {

//    static let sharedInstance = ErrorCodesHandler()
    var errorMessage = "An error has occurred in response"

    override init() {
        super.init()
        self.errorMessage = Constants.appMessages.errorMessage_DefaultErrorMessage
    }

    // MARK: - Get Error Object when error in response
    func getErrorObjectWith(title: String?, message: String?, errorCode: Int?) -> Error {
        let failureError = InternalErrorStruct(_domain: title ?? self.errorMessage, _code: errorCode ?? IOSErrorCodes.responseResultEmpty, _message: message ?? nil)
        return failureError
    }

    // MARK: - Show Error With Code
    func checkAndShowErrorAlert(error: Error) {

        let intCode = error._code
        var errorShowTitle = error._domain
        var errorShowMessage = "Error Code = "
        var showAlert = true
        switch intCode {
        case IOSErrorCodes.multipleServiceCalls:
            showAlert = false
            break
        case IOSErrorCodes.notConnectedToInternet:
            errorShowTitle = Constants.appMessages.noConnectivityMessage
            errorShowMessage = String(format: "Error Code = %d", intCode)
            break
        case ServerErrorCodes.inappropriateDataCode:
            errorShowTitle = Constants.appMessages.errorMessage_InappropriateData_Code400
            errorShowMessage = String(format: "Error Code = %d", intCode)
            break
        default:
//            errorShowTitle = String(format: "Communication Failed with server during synchronisation. This could be due to various reasons. please try again after some time.")
            errorShowTitle = Constants.appMessages.errorMessage_DefaultErrorMessage
            errorShowMessage = String(format: "Error Code = %d", intCode)
            break
        }
        if showAlert {
            let alertView = UIAlertController(title: errorShowTitle, message: errorShowMessage, preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertView.addAction(cancelAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        }
    }
   
    // MARK: - Show Error When We Recieve Response from server
    func showErrorWhenServerResponded(error: Error) {

        let intCode = error._code
        var errorShowTitle = error._domain
        var errorShowMessage = String(format: "Error Code = %d", error._code)
        let showAlertWithAction = false
        switch intCode {
        case ServerErrorCodes.sessionExpireErrorCode, IOSErrorCodes.notConnectedToInternet:
//            showAlertWithAction = true
            errorShowTitle = Constants.appMessages.errorMessage_SessionExpired_Code310
            break
        case IOSErrorCodes.dontShowErrorCode:
            errorShowMessage = ""
            break
        case ServerErrorCodes.inappropriateDataCode:
            errorShowTitle = Constants.appMessages.errorMessage_InappropriateData_Code400
            break
        default:
            break
        }
        if showAlertWithAction == false {
            let alertView = UIAlertController(title: errorShowTitle, message: errorShowMessage, preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertView.addAction(cancelAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        } else {

//            let alertView = UIAlertController(title: "Session Expire. Please login again", message: nil, preferredStyle: UIAlertControllerStyle.alert)
//            let cancelAction = UIAlertAction(title: Constants.StaticAppMessages.alertOkTitle, style: .cancel, handler: { action -> Void in
//                let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                appDelegate?.logoutUser()
//            })
//            alertView.addAction(cancelAction)
//            UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        }
    }

}
