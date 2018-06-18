//
//  WheatherInfo.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit

class WheatherInfo: NSObject {
    
    var currentTemprature:String?;
    var pressure:String?;
    var humidity:String?;
    var maxTemprature:String?;
    var minTemprature:String?;
    var currentClimate:String?
    func createWheatherObject(wheatherInfo:NSDictionary,climateInfo:NSDictionary)->WheatherInfo{
        self.currentTemprature = "\(wheatherInfo["temp"]!)"
        self.pressure =  "\(wheatherInfo["pressure"]!)";
        self.humidity = "\(wheatherInfo["humidity"]!)"
        self.maxTemprature = "\(wheatherInfo["temp_max"]!)"
        self.minTemprature = "\(wheatherInfo["temp_min"]!)"
        self.currentClimate = climateInfo["main"] as? String;
        return self;
    }
    

}
