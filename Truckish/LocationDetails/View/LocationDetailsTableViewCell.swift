//
//  LocationDetailsTableViewCell.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/15/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit

let LocationDetailsTableViewCellReuseidentifier = "locationImageTableViewReuseIdentifier";

class LocationDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    
    //Setup view
    
    func setupView(imageUrl:String)->Void{
        self.cardView?.createCardEffect();
        let url:NSURL = NSURL(string:imageUrl)!;
        placeImageView.sd_setImage(with: url as URL , placeholderImage: UIImage(named: "Placholder.png"), options: .continueInBackground) { (image, error, type, url) in
            if(image != nil){
                self.placeImageView?.image  = nil;
                self.placeImageView?.image = image;
            }
        }
    }
    
}
