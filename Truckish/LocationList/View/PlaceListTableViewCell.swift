//
//  PlaceListTableViewCell.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/15/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit
import SDWebImage


let placeListTableViewCellReuseIdentifier = "PlaceListTableViewCellReuseIdntifier"

class PlaceListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeDescriptionLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupView(placeobject:Places)->Void{
        self.cardView?.createCardEffect();
        self.placeNameLabel.text = placeobject.name!;
        self.placeDescriptionLabel.text = placeobject.placeDescription!;
        let url:NSURL = NSURL(string: placeobject.image_Url!)!;
        placeImageView.sd_setImage(with: url as URL , placeholderImage: UIImage(named: "Placholder.png"), options: .continueInBackground) { (image, error, type, url) in
            if(image != nil){
                self.placeImageView?.image  = nil;
                self.placeImageView?.image = image;
            }
        }
        
    }
    
    
    
}
