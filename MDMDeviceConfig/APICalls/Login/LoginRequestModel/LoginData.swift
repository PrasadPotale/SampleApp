//
//	LoginData.swift
//
//	Create by JenkinsServer on 5/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class LoginData : NSObject, NSCoding{

	var password : String!
	var username : String!


    override init () {
        
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		password = dictionary["password"] as? String
		username = dictionary["username"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if password != nil{
			dictionary["password"] = password
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         password = aDecoder.decodeObject(forKey: "password") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}
