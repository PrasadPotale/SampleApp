//
//  ViewController+APICall.swift
//  MDMDeviceConfig
//
//  Created by JenkinsServer on 05/10/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    func callAPI() {
        let loginRequestModelObject = LoginRequest()
        loginRequestModelObject.userName = self.emailTextField.text!
        loginRequestModelObject.userPassword = self.passwordTextField.text!
        loginRequestModelObject.userType = "Citizen"
        let requestParam = loginRequestModelObject.toDictionary()
        //Call Login service to get CRM_ID
        let blockObject = HTTPRequestBlock()
        blockObject.callPOSTRequestAPI(path: Constants.serviceAPI_Path.loginAuthAPI, andParameters: requestParam as? [String: AnyObject], timeout: Constants.timeoutInterval.timeout) { (aPIResponse) in
            if let failure = aPIResponse.errorObject {
                ErrorCodesHandler().checkAndShowErrorAlert(error: failure)
            } else if let jsonObject = aPIResponse.jsonObject {
                let loginResponse = LoginResponseModel(fromDictionary: jsonObject as! NSDictionary)
                if loginResponse.status.code == Constants.serverResponseCodes.successCode {
                    //here we will get CRM ID and Token in response, Store CRM ID in user default
                    if let CRM_Id = loginResponse.crmId {
                        UserDefaults.standard.set(CRM_Id, forKey: "CRM_ID")
                        if self.checkIfDeviceIDIsPresent() {
                            //Call Status API
                            self.callMDMStatus_API()
                        } else {
                            //Call API to enroll device and in response get deviceId and store deviceID in keychain
                            self.callAPI_ToGet_DeviceID()
                        }
                    }
                }
            }
        }
    }

    /*
     - Check If Device Id already registered, if already registered continue with the flow else
     enroll the device
     */
    //MARK: - Device ID Registration
    func checkIfDeviceIDIsPresent() -> Bool {
        if KeychainItemWrapperArc.keyChainLoadKey(kSecAttrTokenID as String) != nil {
            return true
        } else {
            return false
        }
        // return false
    }

    //MARK:- Call Status API
    func callMDMStatus_API() {
        print("in MDM status")

        let mdmStatusObj = MDM_Enroll_Status_Request()
        if self.checkIfDeviceIDIsPresent() {
            //mdmStatusObj.deviceUniqueId = KeychainItemWrapperArc.keyChainLoadKey(kSecAttrTokenID as String) as! String!
            mdmStatusObj.deviceUniqueId = "f51bb26f-0c70-4531-9daa-bfb1f20e260c"
        }
        let requestParam = mdmStatusObj.toDictionary()
        let blockObject = HTTPRequestBlock()
        blockObject.callPOSTRequestAPI(path: Constants.serviceAPI_Path.checkMDM_Enrollment_Status, andParameters: requestParam as? [String: AnyObject], timeout: Constants.timeoutInterval.timeout, completionHandler: { (aPIResponse) in
            if let failure = aPIResponse.errorObject {
                ErrorCodesHandler().checkAndShowErrorAlert(error: failure)
            } else if let jsonObject = aPIResponse.jsonObject {
                let mdmStatusResponseObj = MDM_Enroll_Status_Response(fromDictionary: jsonObject as! NSDictionary)
                if mdmStatusResponseObj.status.code == Constants.serverResponseCodes.successCode {
                    // call js view
                    print("device status is \(mdmStatusResponseObj.enrolled)")
                    if mdmStatusResponseObj.enrolled! {
                        // If true show detail data of enroll device
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let enrollDeviceDetailViewObj = storyboard.instantiateViewController(withIdentifier: "EnrollDeviceDetailInfoViewController") as! EnrollDeviceDetailInfoViewController
                        enrollDeviceDetailViewObj.mdmStatusReponseObject = mdmStatusResponseObj
                        self.navigationController?.pushViewController(enrollDeviceDetailViewObj, animated: true)
                    } else {
                        // If false load page in webview with CRMID, ORganisation ID and Device ID append to the url (open JS page)
                        let domain: AnyObject = Constants.serviceAPI_Path.jsUrlToLoadPageInSafari as String as AnyObject
                        var deviceId = ""
                        if let token = KeychainItemWrapperArc.keyChainLoadKey(kSecAttrTokenID as String) {
                            deviceId = token as! String
                        }
                        let filePath = String(format: "%@?deviceUniqueId=%@", domain as! String, deviceId)
                        let url: NSURL = NSURL(string: filePath)!
                        print("device Id \(deviceId)")
                        print("filePath \(filePath)")
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url as URL)
                        }
                    }
                }
            }
        })

    }

    //MARK:- Call API to get deviceID
    func callAPI_ToGet_DeviceID() {
        print("API to get Device ID")
        //Send crmId, emailId, organizationId in request
        let deviceIdObject = UniqueDeviceIDRequest()
        deviceIdObject.organizationId = Constants.organizationID
        deviceIdObject.crmId = ""
        if UserDefaults.standard.string(forKey: "CRM_ID") != nil {
            deviceIdObject.crmId = UserDefaults.standard.string(forKey: "CRM_ID")
        }
        if UserDefaults.standard.string(forKey: "emailId") != nil {
            deviceIdObject.emailId = self.emailTextField.text
        }
        let requestParam = deviceIdObject.toDictionary()
        let blockObject = HTTPRequestBlock()
        blockObject.callPOSTRequestAPI(path: Constants.serviceAPI_Path.getUniqueDeviceID, andParameters: requestParam as? [String: AnyObject], timeout: Constants.timeoutInterval.timeout, completionHandler: { (aPIResponse) in
            if let failure = aPIResponse.errorObject {
                ErrorCodesHandler().checkAndShowErrorAlert(error: failure)
            } else if let jsonObject = aPIResponse.jsonObject {
                let deviceIDResponse = UniqueDeviceIDResponse(fromDictionary: jsonObject as! NSDictionary)
                if deviceIDResponse.status.code == Constants.serverResponseCodes.successCode {
                    //Store Device ID in keychain and call js view
                    if let deviceId = deviceIDResponse.deviceUniqueId {
                        let secAttr = kSecAttrTokenID
                        KeychainItemWrapperArc.keyChainSaveKey(secAttr as String!, data: deviceId)
                        //Enroll device here load page in webview with CRMID, ORganisation ID and Device ID append to the url (open JS page)
                        let domain: AnyObject = Constants.serviceAPI_Path.jsUrlToLoadPageInSafari as String as AnyObject
                        var deviceId = ""
                        if let token = KeychainItemWrapperArc.keyChainLoadKey(kSecAttrTokenID as String) {
                            deviceId = token as! String
                        }
                        let filePath = String(format: "%@?deviceUniqueId=%@", domain as! String, deviceId)
                        let url: NSURL = NSURL(string: filePath)!
                        print("device Id \(deviceId)")
                        print("filePath \(filePath)")
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url as URL)
                        }
                    }
                }
            }
        })
    }
}


