//
//  UIButton+UIButtonEffects.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/14/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import Foundation
import UIKit

//Extension for buttons

extension UIButton{
    
    func setCornerRadius()->Void{
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 25.0;
    }
    func setBorderWidth()->Void{
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 1.0;
    }
    func setBorderColor()->Void{
        self.layer.masksToBounds = true;
        self.layer.borderColor = Theme().greenColor().cgColor;
    }
    
    
}
