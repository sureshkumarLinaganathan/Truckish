//
//  UIView+CardEffect.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/16/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import Foundation
import UIKit

//Extension for view

extension UIView{
    
    func createCardEffect()->Void{
        
        self.alpha = 1.0;
        self.layer.masksToBounds = false;
        self.layer.cornerRadius = 0;
        self.layer.shadowOffset = CGSize(width: 0, height: 0);
        self.layer.shadowRadius = 2.0;
        self.layer.shadowColor = UIColor.lightGray.cgColor;
        self.layer.shadowOpacity = 1.0
    }
    
}
