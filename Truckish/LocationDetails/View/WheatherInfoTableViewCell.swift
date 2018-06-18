//
//  WheatherInfoTableViewCell.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit
let WheatherInfoTableViewCellReuseIdenifier = "wheatherInfoTableViewCellReuseIdenifier";

class WheatherInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var currenClimateLabel: UILabel!
    @IBOutlet weak var presureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    func creatCardView()->Void{
       self.cardView.createCardEffect();
    }
    
    func setupView(wheatherInfo:WheatherInfo)->Void{
        self.currentTemperatureLabel.text = wheatherInfo.currentTemprature!;
        self.humidityLabel.text = wheatherInfo.humidity!+"%";
        self.presureLabel.text = wheatherInfo.pressure!;
        self.currenClimateLabel.text = wheatherInfo.currentClimate!;
        self.maxTemperatureLabel.text = wheatherInfo.maxTemprature!;
        self.minimumTemperatureLabel.text = wheatherInfo.minTemprature!;
    }
}
