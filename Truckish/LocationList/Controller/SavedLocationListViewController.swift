//
//  SavedLocationListViewController.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/14/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

let savedLocationListViewControllerSegue:String = "locationListViewControllerSegue";

class SavedLocationListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var placesArray:Array = [Places]();
    var loadingIndicator:NVActivityIndicatorView?
    var loadingView:UIView?
    var selectedPlaceObject:Places = Places();
    
    @IBOutlet weak var errorMsgLabel: UILabel!
    @IBOutlet weak var errorMessageView: UIView!
    
    // View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true;
        self.setupView();
        self.addLoadingIndicator();
        self.fetchListData();
        
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
    
    
    //IBActions
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        Webservice().logout { (status, errorMsg) in
            if(status){
                self.navigationController?.popViewController(animated: true);
            }else{
                let alertController = UIAlertController.init(title:"", message: errorMsg, preferredStyle: .alert);
                let alertAction = UIAlertAction.init(title:"OK", style:.default, handler: { (action) in
                    alertController.dismiss(animated: true, completion:nil);
                })
                alertController.addAction(alertAction);
                self.present(alertController, animated: true, completion: nil);
                
                
            }
        }
    }
    @IBAction func refereshButtonTapped(_ sender: Any) {
        self.tableView.isHidden = true;
        self.errorMessageView.isHidden = true;
        self.fetchListData();
        
    }
    
    //Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier  == locationDetailsViewControllerSegue){
            let locationdetails:LocationDetailsViewController = segue.destination as! LocationDetailsViewController ;
            locationdetails.placeObject = selectedPlaceObject;
        }
    }
}

extension SavedLocationListViewController{
    
    func setupView()->Void{
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg")!);
    }
}

// Webservice Methods

extension SavedLocationListViewController{
    
    func fetchListData()->Void{
        self.placesArray = [Places]();
        self.loadingView?.isHidden = false;
        self.loadingView?.bringSubview(toFront: self.loadingIndicator!);
        self.loadingView?.isUserInteractionEnabled = false;
        self.loadingIndicator?.startAnimating();
        Webservice().fetchDataFromFirebase { (success, errorMsg, array) in
            self.loadingIndicator?.stopAnimating();
            self.loadingView?.isHidden = true;
            self.tableView.isHidden = false;
            if(success){
                if(array.count>0){
                    self.placesArray = array;
                    self.tableView.reloadData();
                }else{
                    self.displayMessage(message:"No Location available!")
                }
            }else{
                self.displayMessage(message: errorMsg);
            }
        }
    }
    
    func displayMessage(message:String)->Void{
        self.view?.bringSubview(toFront: self.errorMessageView);
        self.errorMessageView.isHidden = false;
        self.errorMsgLabel?.text = message;
    }
}

// Tableview data source and delegate methods

extension SavedLocationListViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placesArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placeListCell :PlaceListTableViewCell = tableView.dequeueReusableCell(withIdentifier: placeListTableViewCellReuseIdentifier, for: indexPath) as! PlaceListTableViewCell;
        placeListCell.setupView(placeobject: self.placesArray[indexPath.row]);
        return placeListCell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedPlaceObject = self.placesArray[indexPath.row];
        self.performSegue(withIdentifier:locationDetailsViewControllerSegue, sender: self);
    }
}
