//
//	MDM_Enroll_Status_Response.swift
//
//	Create by JenkinsServer on 6/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MDM_Enroll_Status_Response : NSObject, NSCoding{

    var enrolled : Bool!
	var status : Result!
    var redirectURL : String!
    var assignedUser : AssignedUser!
    var deviceId : String!
    var enrollmentDate : String!
    var mdmStatus : String!

    override init () {
        
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
        enrolled = dictionary["enrolled"] as? Bool
        redirectURL = dictionary["redirectURL"] as? String
		if let statusData = dictionary["status"] as? NSDictionary{
			status = Result(fromDictionary: statusData)
		}
        if let assignedUserData = dictionary["assignedUser"] as? NSDictionary{
            assignedUser = AssignedUser(fromDictionary: assignedUserData)
        }
        deviceId = dictionary["deviceId"] as? String
        enrollmentDate = dictionary["enrollmentDate"] as? String
        mdmStatus = dictionary["mdmStatus"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
        if enrolled != nil{
            dictionary["enrolled"] = enrolled
        }
		if status != nil{
			dictionary["status"] = status.toDictionary()
		}
        if redirectURL != nil {
          dictionary["redirectURL"] = redirectURL
        }
        if assignedUser != nil{
            dictionary["assignedUser"] = assignedUser.toDictionary()
        }
        if deviceId != nil{
            dictionary["deviceId"] = deviceId
        }
        if enrollmentDate != nil{
            dictionary["enrollmentDate"] = enrollmentDate
        }
        if mdmStatus != nil{
            dictionary["mdmStatus"] = mdmStatus
        }
        if status != nil{
            dictionary["status"] = status.toDictionary()
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         enrolled = aDecoder.decodeObject(forKey: "enrolled") as? Bool
         status = aDecoder.decodeObject(forKey: "status") as? Result
         redirectURL = aDecoder.decodeObject(forKey: "redirectURL") as? String
         assignedUser = aDecoder.decodeObject(forKey:"assignedUser") as? AssignedUser
         deviceId = aDecoder.decodeObject(forKey:"deviceId") as? String
         enrollmentDate = aDecoder.decodeObject(forKey:"enrollmentDate") as? String
         mdmStatus = aDecoder.decodeObject(forKey:"mdmStatus") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
        if enrolled != nil{
            aCoder.encode(enrolled, forKey: "enrolled")
        }
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
        if redirectURL != nil {
            aCoder.encode(redirectURL, forKey: "redirectURL")
        }
        if assignedUser != nil{
            aCoder.encode(assignedUser, forKey: "assignedUser")
        }
        if deviceId != nil{
            aCoder.encode(deviceId, forKey: "deviceId")
        }
        if enrollmentDate != nil{
            aCoder.encode(enrollmentDate, forKey: "enrollmentDate")
        }
        if mdmStatus != nil{
            aCoder.encode(mdmStatus, forKey: "mdmStatus")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
	}
}
