//
//  TransactionViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/28/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class TransactionViewController: UITableViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
    createTransaction()
    }
    
    var nodeResponse: [String:Any]?
    var nodeAuthToken: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createTransaction(){
        
        let nodesArray = nodeResponse!["nodes"] as! NSArray
        let nodesDict = nodesArray[0] as! Dictionary<String,AnyObject>
//        print("__________________________________________")
//        print(nodesDict["_id"]!)
//        print(nodesDict["user_id"]!)
//        print("__________________________________________")
        var currencyDouble :Double? = Double(amountTextField.text!)
        
        let userId = nodesDict["user_id"]! as? String
        let nodeId = nodesDict["_id"]! as? String
        
        let parameters: Parameters = [
            "to": [
                "type": "DEPOSIT-US",
                "id": nodeId
            ],
            "amount": [
                "amount": currencyDouble,
                "currency": "USD"
            ],
            "extra": [
                "ip": "192.168.1.1"
            ]
        ]
        
        // Alamofire headers
        let SPUSER = ViewController().valueForAPIKey(named: "USER")
        let SPUSERIP = ViewController().valueForAPIKey(named: "USER-IP")
        
        let userToken = self.nodeAuthToken!["oauth_key"] as! String
        let USER = userToken + SPUSER
        
        let headers: HTTPHeaders = [
            "X-SP-USER": USER,
            "X-SP-USER-IP": SPUSERIP
        ]
        
        // creates the url string
        let baseString = "https://uat-api.synapsefi.com/v3.1/users/"
        let midString = "/nodes/"
        let endString = "/trans"
        let urlString : String = baseString + userId! + midString + nodeId! + endString
        
        //API call to create the DEPOSIT-US node
        Alamofire.request(urlString, method:.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .failure(let status):
                print (status)
            case .success(let value):
                print (value)
                self.displayLabel.text = "Successfully Added"
            }
        }
    }
    
}
