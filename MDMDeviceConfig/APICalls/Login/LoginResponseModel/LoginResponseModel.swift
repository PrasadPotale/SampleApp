//
//	LoginResponseModel.swift
//
//	Create by JenkinsServer on 6/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LoginResponseModel : NSObject, NSCoding{

	var status : Result!
	var token : String!
	var user : User!
    var crmId: String!

    override init () {
        
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let statusData = dictionary["status"] as? NSDictionary{
			status = Result(fromDictionary: statusData)
		}
		token = dictionary["token"] as? String
		if let userData = dictionary["user"] as? NSDictionary{
			user = User(fromDictionary: userData)
		}
        crmId = dictionary["crmId"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if status != nil{
			dictionary["status"] = status.toDictionary()
		}
		if token != nil{
			dictionary["token"] = token
		}
		if user != nil{
			dictionary["user"] = user.toDictionary()
		}
        if crmId != nil {
            dictionary["crmId"] = crmId
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         status = aDecoder.decodeObject(forKey: "status") as? Result
         token = aDecoder.decodeObject(forKey: "token") as? String
         user = aDecoder.decodeObject(forKey: "user") as? User
        crmId = aDecoder.decodeObject(forKey: "crmId") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if token != nil{
			aCoder.encode(token, forKey: "token")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}
        if crmId != nil {
            aCoder.encode(crmId, forKey: "crmId")
        }

	}

}
