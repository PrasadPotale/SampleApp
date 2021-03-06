//
//	MyCityResult.swift
//
//	Create by Piyush on 7/6/2016
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import Foundation


class Result : NSObject, NSCoding{

	var cause : String!
	var code : Int!
	var message : String!
   
    override init() {
        cause = ""
        message = ""
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		cause = dictionary["cause"] as? String
		code = dictionary["code"] as? Int
		message = dictionary["message"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if cause != nil{
			dictionary["cause"] = cause
		}
		if code != nil{
			dictionary["code"] = code
		}
		if message != nil{
			dictionary["message"] = message
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cause = aDecoder.decodeObject(forKey: "cause") as? String
         code = aDecoder.decodeObject(forKey: "code") as? Int
         message = aDecoder.decodeObject(forKey: "message") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if cause != nil{
			aCoder.encode(cause, forKey: "cause")
		}
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}

	}

}
