//
//  LocationDetailsViewController.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/15/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView

let locationDetailsViewControllerSegue:String = "locationDetailSegue";

class LocationDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    public var placeObject:Places?;
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    var currentLocation:CLLocationCoordinate2D?;
    var loadingIndicator:NVActivityIndicatorView?
    var loadingView:UIView?
    
    @IBOutlet weak var tableView: UITableView!
    var locationManager:CLLocationManager?;
    var otherInfo :OtherInfo?;
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true;
        self.setupView();
    }
    
    //IBActions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated:true);
    }
    
    @IBAction func showInMapButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier:mapViewControllerSegue, sender: self)
    }
    
    //Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier  == mapViewControllerSegue){
            let mapViewController:MapViewController = segue.destination as! MapViewController ;
            mapViewController.placeObject = self.placeObject!;
            mapViewController.currentLocation = self.currentLocation;
        }
    }
    
}

// Tableview data source and delegate methods

extension LocationDetailsViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let locationDescriptionCell:LocationDescriptionTableViewCell = tableView.dequeueReusableCell(withIdentifier:LocationDescriptionTableViewCellReuseIdentifier, for: indexPath) as!LocationDescriptionTableViewCell
            locationDescriptionCell.setupView(locationDescription: (placeObject?.placeDescription)!);
            return locationDescriptionCell;
        }else{
            
            let addressTableviewCell:AddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCellReuseIdentifier, for: indexPath) as! AddressTableViewCell;
            if(self.otherInfo != nil){
                addressTableviewCell.setupView(otherInfo:self.otherInfo!);
            }else{
                self.otherInfo?.distance = "---";
                self.otherInfo?.duration = "---";
                self.otherInfo?.sourceAddress = "---";
                self.otherInfo?.destinationAddress = "---";
            }
            return addressTableviewCell;
        }
        
    }
}

//Core location methods

extension LocationDetailsViewController:CLLocationManagerDelegate{
    
    func setupView()->Void{
        self.addLoadingIndicator();
        self.getCurrentLocation();
        self.titleLabel.text = placeObject?.name!;
        self.cardView?.createCardEffect();
        let url:NSURL = NSURL(string: (self.placeObject?.image_Url)!)!;
        placeImageView.sd_setImage(with: url as URL , placeholderImage: UIImage(named: "Placholder.png"), options: .continueInBackground) { (image, error, type, url) in
            if(image != nil){
                self.placeImageView?.image  = nil;
                self.placeImageView?.image = image;
            }
        }
    }
    func addLoadingIndicator()->Void{
        self.loadingView = UIView.init(frame: self.view.frame);
        self.loadingView?.backgroundColor = Theme().loadingIndicatorBackgroundColor();
        self.loadingView?.isUserInteractionEnabled = false;
        self.loadingIndicator = NVActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballSpinFadeLoader, color: UIColor.orange, padding: 0)
        self.loadingIndicator?.center = (self.loadingView?.center)!;
        self.loadingView?.addSubview(self.loadingIndicator!);
        self.view?.addSubview(self.loadingView!);
        self.loadingView?.isHidden = true;
        
    }
    
    func getCurrentLocation()->Void{
        
        self.locationManager = CLLocationManager.init();
        locationManager?.delegate = self as CLLocationManagerDelegate;
        self.locationManager?.requestWhenInUseAuthorization();
        self.locationManager?.distanceFilter = kCLDistanceFilterNone;
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager?.startUpdatingLocation();
    }
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first;
        let lat = location?.coordinate.latitude;
        let lan = location?.coordinate.longitude;
        self.currentLocation = CLLocationCoordinate2DMake(lat!, lan!);
        self.locationManager?.stopUpdatingLocation();
        self.calculateDistance(lat: lat!,lan:lan!);
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        self.locationManager?.stopUpdatingLocation();
    }
    func calculateDistance(lat:Double,lan:Double) ->Void{
        let sourceDestination:String = String(lat)+","+String(lan);
        self.loadingView?.isHidden = false;
        self.loadingView?.bringSubview(toFront: self.loadingIndicator!);
        self.loadingView?.isUserInteractionEnabled = false;
        self.loadingIndicator?.startAnimating();
        Webservice().calculateDistanceFromSourceToDestibation(sourceLocation: sourceDestination, destinationLocation: (self.placeObject?.location)!) { (success, error, otherInfo) in
            self.loadingIndicator?.stopAnimating();
            self.loadingView?.isHidden = true;
            if(success){
                self.otherInfo = otherInfo[0] as OtherInfo;
                self.tableView.reloadSections(IndexSet(integer:1), with: .top);
                
            }
            
        }
    }
    
}
