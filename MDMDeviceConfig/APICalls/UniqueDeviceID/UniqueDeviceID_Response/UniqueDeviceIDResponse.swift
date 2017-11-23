//
//	UniqueDeviceIDResponse.swift
//
//	Create by JenkinsServer on 6/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UniqueDeviceIDResponse : NSObject, NSCoding{

	var deviceUniqueId : String!
	var status : Result!


    override init () {
        
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		deviceUniqueId = dictionary["deviceUniqueId"] as? String
		if let statusData = dictionary["status"] as? NSDictionary{
			status = Result(fromDictionary: statusData)
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if deviceUniqueId != nil{
			dictionary["deviceUniqueId"] = deviceUniqueId
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
         deviceUniqueId = aDecoder.decodeObject(forKey: "deviceUniqueId") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Result

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if deviceUniqueId != nil{
			aCoder.encode(deviceUniqueId, forKey: "deviceUniqueId")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}

	}

}
