//
//  Places.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/15/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit

class Places: NSObject {
    
    var name:String?
    var location :String?
    var image_Url:String?
    var placeDescription:String?
    
    // Parse place obeject
    
    func createPlacesobject(dictionary:NSDictionary) ->Places{
        
        self.name = dictionary["name"] as? String;
        self.location = dictionary["location"]as? String;
        self.image_Url = dictionary["image_url"]as? String;
        self.placeDescription = dictionary["description"]as? String;
        return self;
    }
}
