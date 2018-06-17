//
//  Theme.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/14/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit

class Theme: NSObject {
    
     //Create custom color
    
    
    func greenColor()->UIColor{
        
        return  UIColor.init(red: 42.0/255.0, green:97.0/255.0, blue: 31.0/255.0, alpha: 1.0);
    }
    
    func lightGreenColor()->UIColor{
        return UIColor.init(red: 42.0/255.0, green:97.0/255.0, blue: 31.0/255.0, alpha:0.5);
    }
    func loadingIndicatorBackgroundColor()->UIColor{
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5);
    }
    
}
