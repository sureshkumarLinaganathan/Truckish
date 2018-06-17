//
//  LogInViewController.swift
//  Truckish
//
//  Created by Sureshkumar Linganathan on 6/14/18.
//  Copyright © 2018 Truckish. All rights reserved.
//

import UIKit
import NVActivityIndicatorView



class LogInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var errorMsgLabel: UILabel!
    var loadingIndicator:NVActivityIndicatorView?
    var loadingView:UIView?
    
    @IBOutlet weak var animationViewTopConstraint: NSLayoutConstraint!
    // View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        self.addLoadingIndicator();
    }
    func addLoadingIndicator()->Void{
        self.loadingView = UIView.init(frame: self.animationView.frame);
        self.loadingView?.backgroundColor = Theme().loadingIndicatorBackgroundColor();
        self.loadingView?.isUserInteractionEnabled = false;
        self.loadingIndicator = NVActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballSpinFadeLoader, color: UIColor.orange, padding: 0)
        self.loadingIndicator?.center = (self.loadingView?.center)!;
        self.loadingView?.addSubview(self.loadingIndicator!);
        self.view?.addSubview(self.loadingView!);
        self.loadingView?.isHidden = true;
        
    }
    // IBActions
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        self.hideKeyBoard();
        self.textFieldDownAnimation();
        self.errorMsgLabel?.isHidden = true;
        self.loadingView?.isHidden = false;
        self.loadingView?.bringSubview(toFront: self.loadingIndicator!);
        self.loadingView?.isUserInteractionEnabled = true;
        self.loadingIndicator?.startAnimating();
        Webservice().login(userName: self.userNameTextField.text!, password: self.passwordTextField.text!) { (success, errorMsg) in
            self.loadingIndicator?.stopAnimating();
            self.loadingView?.isHidden = true;
            if(success){
                self.userNameTextField?.text = "";
                self.passwordTextField?.text = "";
                self.setButtonDisabled();
                self.performSegue(withIdentifier:savedLocationListViewControllerSegue, sender: self);
            }else{
                self.displayErrorMessage(message: errorMsg);
            }
        }
        
    }
    
    func displayErrorMessage(message:String)->Void{
        self.errorMsgLabel.isHidden = false;
        self.errorMsgLabel?.text =  message;
    }
    
    
}

//Text field delegate methods

extension LogInViewController:UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldDownAnimation();
        textField.resignFirstResponder();
        return true;
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(((range.location == 0)&&(range.length == 1))&&((self.userNameTextField.text?.count == 1)||(self.passwordTextField.text?.count == 1))){
            self.setButtonDisabled();
        }else if((textField == self.userNameTextField)&&(!(self.passwordTextField.text?.count == 0))){
            self.setButtonEnabled();
        }else if((textField == self.passwordTextField)&&(!(self.userNameTextField.text?.count == 0))){
            self.setButtonEnabled();
        }
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.setButtonDisabled();
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textFieldUpAnimation()
    }
}

// View Setup

extension LogInViewController{
    
    func setupView()->Void{
        
        self.animationView.backgroundColor =  UIColor(patternImage: UIImage(named:"bg")!);
        self.navigationController?.isNavigationBarHidden = true;
        self.setButtonDisabled();
        self.setCorenerRadius();
        self.setBorderColor();
        self.setBorderWidth();
        self.setPadding();
        
        self.logoImageView?.layer.masksToBounds = true;
        self.logoImageView?.layer.cornerRadius = self.logoImageView.frame.size.height/2;
    }
    
    func setCorenerRadius()->Void{
        self.userNameTextField.setCornerRadius();
        self.passwordTextField.setCornerRadius();
        self.signInButton.setCornerRadius();
        
    }
    
    func setBorderWidth()->Void{
        self.userNameTextField.setBorderWidth();
        self.passwordTextField.setBorderWidth();
        self.signInButton.setBorderWidth();
    }
    
    func setBorderColor()->Void{
        self.userNameTextField.setBorderColor();
        self.passwordTextField.setBorderColor();
        self.signInButton.setBorderColor();
        
    }
    
    func setPadding()->Void{
        var view :UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 7, height: 20));
        self.userNameTextField.leftView = view;
        self.userNameTextField.leftViewMode = .always;
        view = UIView.init(frame: CGRect(x: 0, y: 0, width: 7, height: 20));
        self.passwordTextField.leftView = view;
        self.passwordTextField.leftViewMode = .always;
        
    }
    
    func setButtonDisabled()->Void{
        self.signInButton.isEnabled = false;
        self.signInButton.backgroundColor = Theme().lightGreenColor();
    }
    func setButtonEnabled()->Void{
        self.signInButton.isEnabled = true;
        self.signInButton.backgroundColor = Theme().greenColor();
    }
    
    func hideKeyBoard()->Void{
        self.userNameTextField.resignFirstResponder();
        self.passwordTextField.resignFirstResponder();
    }
}

// Textfield Animation

extension LogInViewController{
    
    func textFieldUpAnimation()->Void{
        self.animationViewTopConstraint.constant = -120;
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded();
        }
    }
    
    func textFieldDownAnimation()->Void{
        self.animationViewTopConstraint.constant = 0;
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded();
        }
    }
}
