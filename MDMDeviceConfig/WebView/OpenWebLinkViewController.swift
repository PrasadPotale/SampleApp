//
//  OpenWebLinkViewController.swift
//  MyCity311
//
//  Created by Piyush on 6/15/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit
import MBProgressHUD

class OpenWebLinkViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var customWebView: UIWebView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerViewTopConstaraint: NSLayoutConstraint!

    var webLink: NSURL!
    var headerTextString: String!
    var calledViewController: Int!
    var selectedView: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("** OpenWebLinkViewController deinit called **")
    }

    func setUpView() {
        if CheckConnectivity.hasConnectivity() && self.webLink != nil {
            //let url = URL(string: self.webLink)
            if self.webLink != nil {
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud?.labelText = "Processing"
                let urlRequest = URLRequest(url: self.webLink as URL)
                print("url in weblink \(self.webLink)")
                self.customWebView.scalesPageToFit = true
                self.customWebView.loadRequest(urlRequest)
            }
        } else {
           /* let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
            let errorMsg = appName + ", " + self.getLocalizedValueFor(key: "networkconnectionMsg", value: "networkconnectionMsg")
            self.showAlertViewMessage(title: self.getLocalizedValueFor(key: "networkErrorTitle", value: "networkErrorTitle"), message: errorMsg)*/
        }
    }

    //MARK:- UIWebViewDelegate methods
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        /*let intCode = error._code
        var title = String(format: "%@ %d", error._domain, intCode)
        var message = "Login Error"
        if intCode == Constants.ServerResponseCodes.countryErrorCode {
            title = Constants.StaticAppMessages.defaultErrorMessage
            message = ""
        } else if intCode == Constants.ServerResponseCodes.multipleServiceCallError {
            title = self.getLocalizedValueFor(key: "requestCancelledErrorMsg", value: "requestCancelledErrorMsg")
            message = String(format: "%@%d", self.getLocalizedValueFor(key: "errorCodeTitle", value: "errorCodeTitle"), intCode)
        }
        self.showAlertViewMessage(title: title, message: message)*/
    }
}
