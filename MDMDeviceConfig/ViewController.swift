//
//  ViewController.swift
//  MDMDeviceConfig
//
//  Created by Piyush Rathi on 04/10/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ViewController: UIViewController {

    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    var enrollPageWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.emailTextField.keyboardType = .emailAddress
        self.passwordTextField.isSecureTextEntry = true
        self.dropShadow(color: .black, offSet: CGSize(width: -1, height: 1), view: self.textFieldView)
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 3, scale: Bool = true, view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offSet
        view.layer.shadowRadius = radius
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    // MARK: - Login Button Action
    @IBAction func onLoginButtonClicked(_ sender: Any) {
        //Do validation
        if self.validateDataInput() {
          //Call API
            print("Call API")
            self.callAPI()
        }
        
    }

    // MARK: - Validating Fields
    func validateDataInput() -> Bool {
        if self.emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0{
            self.showAlertMethod(receivedTitle: "", receivedMessage: Constants.appMessages.enterUsernameMsg)
            return false
        } else if !self.isValidEmail(self.emailTextField.text! as String) {
            self.showAlertMethod(receivedTitle: "", receivedMessage: Constants.appMessages.invalidUsernameMsg)
            return false
        } else if self.passwordTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0{
            self.showAlertMethod(receivedTitle: "", receivedMessage: Constants.appMessages.enterPasswordMsg)
            return false
        } /*else if !self.isValidPassword(self.passwordTextField.text! as String) {
            self.showAlertMethod(receivedTitle: "", receivedMessage: Constants.appMessages.invalidPasswordMsg)
            return false
        }*/
      return true
    }
    
    //MARK:- Validate Email address
    func isValidEmail(_ testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //MARK:- Validate Password
    func isValidPassword(_ value: String) -> Bool {
        let PHONE_REGEX = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)[A-Za-z\\d]{8,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    // MARK: - Show Alert Method
    func showAlertMethod(receivedTitle: String, receivedMessage: String) {
        let alertView = UIAlertController(title: receivedTitle, message:receivedMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}

