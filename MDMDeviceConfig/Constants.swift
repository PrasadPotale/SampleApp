//
//  Constants.swift
//  MDMDeviceConfig
//
//  Created by Piyush Rathi on 04/10/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

import Foundation

struct Constants {
    
    static let organizationID = "59d38ea35866234ca2333ceb"
    
    enum timeoutInterval {
        static let minTimout = 60
        static let timeout = 120
        static let maxTimout = 240
    }
    enum appMessages {
        static let forgotPasswordSuccess = "Password reset link sent to your registered email address."
        static let socialLoginMsg = "requires some more information for login. \nThis is one time process and it will not bother you again. \nThank You!"
        static let noConnectivityTitle = "Network Error"
        static let noConnectivityMessage = "Application requires network access either through WiFi or Mobile network."
        static let enterUsernameMsg = "Please enter username."
        static let enterPasswordMsg = "Please enter password."
        static let invalidUsernameMsg = "Please enter valid username."
        static let invalidPasswordMsg = "Please enter valid password."
        static let errorAlertTitle = "Error"
        static let errorAlertMsg = "Error occured in Login Response"
        static let errorAlert_DeviceID_Msg = "Error occured in Device ID Response"
        static let errorAlert_MDMEnrollStatus_Msg = "Error occured in MDM Enroll Status Response"
        static let errorMessage_InappropriateData_Code400 = "User does not exists with given credentials"
        static let errorMessage_SessionExpired_Code310 = "Session Expired"
        static let errorMessage_DefaultErrorMessage = "Communication Failed with server during synchronisation. This could be due to various reasons. please try again after some time."
    }
    
    enum serviceAPI_Path {
        //static let loginAuthAPI = "https://api.logcamp.net/datarepo/authUser"
        static let loginAuthAPI = "https://mycity-api.kahunaapps.io/CAP/rest/auth/1/authenticate"
        static let getUniqueDeviceID = "https://tomcat.kahunasystems.com/mdm/api/rest/device/deviceUniqueId/generate"
        static let checkMDM_Enrollment_Status = "https://tomcat.kahunasystems.com/mdm/api/rest/device/enrollment/status"
        static let jsUrlToLoadPageInSafari = "http://192.168.0.38:8080/MDMMobile/"
    }
    
    enum serverResponseCodes {
        static let successCode: Int = 200
    }
    
    enum enrollmentViewConstants {
        static let assignedUserIdKeyName = "Assigned User Id:"
        static let assignedUserCrmIdKeyName = "Assigned User CrmId:"
        static let deviceIdKeyName = "DeviceId:"
        static let enrollmentDateKeyName = "Enrollment Date:"
        static let mdmStatusKeyName = "MDM Status:"
    }

}
