//
//	UniqueDeviceIDRequest.swift
//
//	Create by JenkinsServer on 6/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UniqueDeviceIDRequest : NSObject, NSCoding{

	var crmId : String!
	var organizationId : String!
    var emailId : String!

    override init () {
        
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		crmId = dictionary["crmId"] as? String
		organizationId = dictionary["organizationId"] as? String
        emailId = dictionary["emailId"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if crmId != nil{
			dictionary["crmId"] = crmId
		}
		if organizationId != nil{
			dictionary["organizationId"] = organizationId
		}
        if emailId != nil{
            dictionary["emailId"] = emailId
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         crmId = aDecoder.decodeObject(forKey: "crmId") as? String
         organizationId = aDecoder.decodeObject(forKey: "organizationId") as? String
         emailId = aDecoder.decodeObject(forKey: "emailId") as? String
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
		if organizationId != nil{
			aCoder.encode(organizationId, forKey: "organizationId")
		}
        if emailId != nil {
            aCoder.encode(emailId, forKey: "emailId")
        }

	}

}
