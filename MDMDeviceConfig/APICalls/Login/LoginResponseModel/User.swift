//
//	User.swift
//
//	Create by JenkinsServer on 6/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class User : NSObject, NSCoding{

	var email : String!
	var name : String!
	var role : String!
	var userId : String!

    override init () {
        
    }
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		email = dictionary["email"] as? String
		name = dictionary["name"] as? String
		role = dictionary["role"] as? String
		userId = dictionary["userId"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if email != nil{
			dictionary["email"] = email
		}
		if name != nil{
			dictionary["name"] = name
		}
		if role != nil{
			dictionary["role"] = role
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         email = aDecoder.decodeObject(forKey: "email") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         role = aDecoder.decodeObject(forKey: "role") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if role != nil{
			aCoder.encode(role, forKey: "role")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}
