//
//	LoginRequest.swift
//
//	Create by JenkinsServer on 5/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LoginRequest : NSObject, NSCoding{

	var data : LoginData!
    var userName: String!
    var userPassword: String!
    var userType: String!
    
    override init () {
        
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let dataData = dictionary["data"] as? NSDictionary{
			data = LoginData(fromDictionary: dataData)
		}
        userName = dictionary["userName"] as? String
        userPassword = dictionary["userPassword"] as? String
        userType = dictionary["userType"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
        if userName != nil {
            dictionary["userName"] = userName
        }
        if userPassword != nil {
            dictionary["userPassword"] = userPassword
        }
        if userType != nil {
            dictionary["userType"] = userType
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey: "data") as? LoginData
        userName = aDecoder.decodeObject(forKey: "userName") as? String
        userPassword = aDecoder.decodeObject(forKey: "userPassword") as? String
        userType = aDecoder.decodeObject(forKey: "userType") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
        if userName != nil {
            aCoder.encode(userName, forKey: "userName")
        }
        if userPassword != nil {
            aCoder.encode(userPassword, forKey: "userPassword")
        }
        if userType != nil {
            aCoder.encode(userType, forKey: "userType")
        }

	}

}
