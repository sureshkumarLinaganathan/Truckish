//
//  Webservice.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/14/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class Webservice: NSObject {
    // Places api
    let mapApi:String = "https://maps.googleapis.com/maps/api/";
    let geocodeKey:String = "geocode/";
    let apiKey:String = "AIzaSyDLWmUt1cPpTYf93WgigVU0DcH7tnreicA";
    let responseFormat = "json?";
    let distanceMatrixKey = "distancematrix/"
    let unitsKey = "units=imperial&";
    //Wheather api
    let wheatherApi = "https://openweathermap.org/data/2.5/weather?";
    let wheatherAppID = "appid=b6907d289e10d714a6e88b30761fae22";
    
    
    func login(userName:String, password:String,callback:@escaping (_ success:Bool,_ Error:String)->Void)->Void{
        Auth.auth().signIn(withEmail: userName, password: password) { (authResult, error) in
            if(error == nil){
                callback(true,"Suceess");
            }else{
                callback(false,(error?.localizedDescription)!);
            }
        }
        
    }
    
    func fetchDataFromFirebase(callback:@escaping (_ success:Bool,_ Error:String,_ PlacesArray:Array<Places>)->Void) -> Void{
        var placesArray:Array = [Places]();
        let databaseReference:DatabaseReference = Database.database().reference();
        databaseReference.observe(.value, with:{ (data) in
            
            let places = data.value as? NSDictionary
            for(_,value) in places!{
                let placeObj =  Places().createPlacesobject(dictionary: value as! NSDictionary);
                placesArray.append(placeObj);
            }
            callback(true,"success",placesArray);
            
        }) { (error) in
            print(error.localizedDescription);
            callback(false,error.localizedDescription,placesArray);
        }
    }
    
    func logout(callback:@escaping (_ success:Bool,_ Error:String)->Void)->Void{
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            callback(false,signOutError.localizedDescription);
            print ("Error signing out: %@", signOutError)
        }
        callback(true,"Sucess");
    }
    
    func fetchAddressFromLocationCoordinate(latAndlan:String,callback:@escaping (_ success:Bool,_ Error:String,_ address:String)->Void)->Void{
        let parameter:String = "latlng="+latAndlan;
        let urlString = mapApi+geocodeKey+responseFormat+parameter+"&key="+apiKey;
        let url:NSURL = NSURL(string:urlString)!
        let theRequest :NSURLRequest = NSURLRequest.init(url: url as URL);
        let task = URLSession.shared.dataTask(with: theRequest as URLRequest) { (data, response, error) in
            do {
                if data?.count != 0 && error == nil {
                    let jsonObject:NSDictionary = try JSONSerialization.jsonObject(with: data!, options:.mutableLeaves) as! NSDictionary;
                    let addresSValue :NSArray = jsonObject["results"] as! NSArray;
                    let formatedAddress:NSDictionary = addresSValue[0] as! NSDictionary;
                    let address :String =   formatedAddress["formatted_address"] as!String;
                    DispatchQueue.main.async {
                        callback(true,"", address);
                    }
                }
            }catch let error as NSError {
                DispatchQueue.main.async {
                    callback(false,error.localizedDescription, "");
                }
            }
        }
        
        task.resume();
        
        
    }
    
    func calculateDistanceFromSourceToDestibation(sourceLocation:String, destinationLocation:String,callback:@escaping (_ success:Bool,_ Error:String,_ otherInfo:Array<OtherInfo>)->Void)->Void{
        var otherInfo:Array = [OtherInfo]();
        let parameter:String = "origins="+sourceLocation+"&destinations="+destinationLocation;
        let urlString = self.mapApi+self.distanceMatrixKey+self.responseFormat+self.unitsKey+parameter+"&key="+apiKey;
        let url:NSURL = NSURL(string:urlString)!
        let theRequest :NSURLRequest = NSURLRequest.init(url: url as URL);
        let task = URLSession.shared.dataTask(with: theRequest as URLRequest) { (data, response, error) in
            do {
                if data?.count != 0 && error == nil {
                    let jsonObject:NSDictionary = try JSONSerialization.jsonObject(with: data!, options:.mutableLeaves) as! NSDictionary;
                    let object =  OtherInfo().createOtherInfo(dictionary: jsonObject);
                    otherInfo.append(object);
                    DispatchQueue.main.async {
                        callback(true,"",otherInfo);
                    }
                }
            }catch let error as NSError {
                DispatchQueue.main.async {
                    callback(false,error.localizedDescription,otherInfo);
                }
            }
        }
        
        task.resume();
    }
    func fetchWheatherInfo(lat:String, lan:String,callback:@escaping (_ success:Bool,_ Error:String,_ otherInfo:Array<WheatherInfo>)->Void)->Void{
        var wheatherInfo:Array = [WheatherInfo]();
        let urlString:String = self.wheatherApi+"lat="+lat+"&"+"lon="+lan+"&"+self.wheatherAppID;
        let url:NSURL = NSURL(string:urlString)!
        let theRequest :NSURLRequest = NSURLRequest.init(url: url as URL);
        let task = URLSession.shared.dataTask(with: theRequest as URLRequest) { (data, response, error) in
            do {
                if data?.count != 0 && error == nil {
                    let jsonObject:NSDictionary = try JSONSerialization.jsonObject(with: data!, options:.mutableLeaves) as! NSDictionary;
                    let wheather:NSDictionary = jsonObject["main"]as! NSDictionary ;
                    let array:NSArray = jsonObject["weather"] as! NSArray;
                    let climate:NSDictionary = array[0] as! NSDictionary;
                    let object = WheatherInfo().createWheatherObject(wheatherInfo: wheather, climateInfo: climate);
                    wheatherInfo.append(object);
                    DispatchQueue.main.async {
                    callback(true,",",wheatherInfo)
                    }
                }
            }catch let error as NSError {
                DispatchQueue.main.async {
                   callback(false,error.localizedDescription,wheatherInfo)
                }
            }
        }
        
        task.resume();
        
    }
    
}


