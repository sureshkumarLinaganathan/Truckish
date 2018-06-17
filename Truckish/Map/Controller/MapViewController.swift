//
//  MapViewController.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/17/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit
import GoogleMaps

let mapViewControllerSegue:String =  "mapViewControllerSegue";


class MapViewController: UIViewController {
    public var placeObject:Places?;
    @IBOutlet weak var mapView: UIView!
    var currentLocation:CLLocationCoordinate2D?;
    
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapView()
    }
    
    //IBActions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated:true);
    }
    
}

// Setup View
extension MapViewController{
    func setupMapView()->Void{
        let array:Array = [(self.placeObject?.location)! .components(separatedBy: ",")]
        let stringArray:Array = array[0];
        let lat:Double = Double(stringArray[0] as String)!;
        let lan:Double = Double(stringArray[1] as String)!;
        let camera = GMSCameraPosition.camera(withLatitude:lat, longitude: lan, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame:CGRect(x: 0, y: 0, width:self.mapView.frame.size.width, height: self.mapView.frame.size.height), camera: camera)
        self.mapView.addSubview(mapView);
        
        // Creates a marker in the center of the map.
        var  marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude:lan)
        marker.title = (self.placeObject?.name)!
        marker.snippet = "India"
        marker.map = mapView
        
        marker = GMSMarker()
        marker.position = self.currentLocation!;
        marker.title = "";
        marker.snippet = "India"
        marker.map = mapView
        
        let path:GMSMutablePath = GMSMutablePath();
        let destinationCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude:lan);
        path.add(destinationCoordinate);
        path.add(self.currentLocation!);
        let polyline = GMSPolyline(path: path);
        polyline.strokeWidth = 5.0;
        polyline.strokeColor = UIColor.yellow;
        polyline.geodesic = true;
        polyline.map = mapView;
    }
}
