//
//  OtherInfo.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/17/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit

class OtherInfo: NSObject {
    
    var sourceAddress:String?;
    var destinationAddress:String?;
    var distance:String?;
    var duration:String?;
    
    //Parse address object
    
    func createOtherInfo(dictionary:NSDictionary)->OtherInfo{
        var array :NSArray = (dictionary["origin_addresses"] as? NSArray)!;
        self.sourceAddress = array[0] as? String;
        array = (dictionary["destination_addresses"] as? NSArray)!;
        self.destinationAddress = array[0] as?String;
        array = (dictionary["rows"] as? NSArray)!;
        var dict = array[0] as? NSDictionary;
        array = (dict! ["elements"] as? NSArray)!;
        dict = array[0] as? NSDictionary;
        let distanceDict = (dict! ["distance"] as? NSDictionary)!;
        self.distance =  distanceDict["text"] as? String;
        let durationDict = (dict! ["duration"] as? NSDictionary)!;
        self.duration = durationDict["text"] as? String;
        return self;
    }
}
