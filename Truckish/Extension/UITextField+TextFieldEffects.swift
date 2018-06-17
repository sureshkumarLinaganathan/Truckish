//
//  UITextField+TextFieldEffects.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/14/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import Foundation
import UIKit

//Extension for textfield

extension UITextField{
    
    func setCornerRadius()->Void{
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 27.0;
    }
    func setBorderWidth()->Void{
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 1.0;
    }
    func setBorderColor()->Void{
        self.layer.masksToBounds = true;
        self.layer.borderColor = UIColor.lightGray.cgColor;
    }
}
