//
//  EnrollDeviceDetailInfoViewController.swift
//  MDMDeviceConfig
//
//  Created by JenkinsServer on 25/10/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

import UIKit

class EnrollDeviceDetailInfoViewController: UIViewController {

    @IBOutlet weak var deviceInfoTable: UITableView!
    var mdmStatusReponseObject: MDM_Enroll_Status_Response!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.deviceInfoTable.register(UINib(nibName: "EnrollDeviceDetailInfoCell", bundle: nil), forCellReuseIdentifier: "EnrollDeviceDetailInfoCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TABLEVIEW DATASOURCE AND DELEGATES
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell: EnrollDeviceDetailInfoCell = tableView.dequeueReusableCell(withIdentifier: "EnrollDeviceDetailInfoCell", for: indexPath) as! EnrollDeviceDetailInfoCell
        self.deviceInfoTable.separatorStyle = UITableViewCellSeparatorStyle.none
        cell = self.setCellData(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        print("did select row at index path")
    }
    
    //MARK:- Set Cell Data
    func setCellData(cell: EnrollDeviceDetailInfoCell, indexPath: IndexPath) ->  EnrollDeviceDetailInfoCell{
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = Constants.enrollmentViewConstants.assignedUserIdKeyName
            cell.valueLabel.text = "N/A"
            if let assignUserId = mdmStatusReponseObject.assignedUser.id {
                cell.valueLabel.text = assignUserId as String
            }
            break
        case 1:
            cell.keyLabel.text = Constants.enrollmentViewConstants.assignedUserCrmIdKeyName
            cell.valueLabel.text = "N/A"
            if let crmID = mdmStatusReponseObject.assignedUser.crmId {
                cell.valueLabel.text = crmID as String
            }
            break
        case 2:
            cell.keyLabel.text = Constants.enrollmentViewConstants.deviceIdKeyName
            cell.valueLabel.text = "N/A"
            if let deviceId = mdmStatusReponseObject.deviceId {
                cell.valueLabel.text = deviceId as String
            }
            break
        case 3:
            cell.keyLabel.text = Constants.enrollmentViewConstants.enrollmentDateKeyName
            cell.valueLabel.text = "N/A"
            if let enrollmentDate = mdmStatusReponseObject.enrollmentDate {
                cell.valueLabel.text = enrollmentDate as String
            }
            break
        case 4:
            cell.keyLabel.text = Constants.enrollmentViewConstants.mdmStatusKeyName
            cell.valueLabel.text = "N/A"
            if let mdmStatus = mdmStatusReponseObject.mdmStatus {
                cell.valueLabel.text = mdmStatus as String
            }
            break
        default:
            cell.keyLabel.text = mdmStatusReponseObject.assignedUser.crmId
            cell.valueLabel.text = "N/A"
            if let crmID = mdmStatusReponseObject.assignedUser.crmId {
                cell.valueLabel.text = crmID as String as String
            }
            break
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
