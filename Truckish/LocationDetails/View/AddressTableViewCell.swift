//
//  AddressTableViewCell.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/17/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit

let AddressTableViewCellReuseIdentifier = "addressTableViewCellReuseIdentifier";

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currentAddressLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var destinationAddressLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    
    //Setup view
    
    func creatCardView()->Void{
        self.cardView.createCardEffect();
    }
    
    func setupView(otherInfo:OtherInfo)->Void{
        self.currentAddressLabel?.text = (otherInfo.sourceAddress) ?? "---" ;
        self.destinationAddressLabel?.text = (otherInfo.destinationAddress) ?? "---";
        self.distanceLabel?.text = (otherInfo.distance) ?? "---";
        self.durationLabel?.text = (otherInfo.duration) ?? "---";
    }
    
}
