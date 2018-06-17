//
//  LocationDescriptionTableViewCell.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/16/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit

let LocationDescriptionTableViewCellReuseIdentifier :String = "locationDescriptionTableViewReuseIdentifier";

class LocationDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    //Setup view
    
    func setupView(locationDescription:String)->Void{
        self.cardView?.createCardEffect();
        self.descriptionLabel?.text = locationDescription;
    }
    
}
