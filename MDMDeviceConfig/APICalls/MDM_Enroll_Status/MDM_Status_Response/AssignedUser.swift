//
//	AssignedUser.swift
//
//	Create by JenkinsServer on 13/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AssignedUser : NSObject, NSCoding{

	var crmId : String!
	var emailId : String!
	var id : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		crmId = dictionary["crmId"] as? String
		emailId = dictionary["emailId"] as? String
		id = dictionary["id"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if crmId != nil{
			dictionary["crmId"] = crmId
		}
		if emailId != nil{
			dictionary["emailId"] = emailId
		}
		if id != nil{
			dictionary["id"] = id
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         crmId = aDecoder.decodeObject(forKey:"crmId") as? String
         emailId = aDecoder.decodeObject(forKey:"emailId") as? String
         id = aDecoder.decodeObject(forKey:"id") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if crmId != nil{
			aCoder.encode(crmId, forKey: "crmId")
		}
		if emailId != nil{
			aCoder.encode(emailId, forKey: "emailId")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}

	}

}
