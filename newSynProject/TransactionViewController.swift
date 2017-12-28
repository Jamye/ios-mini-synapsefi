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
    
    var nodeResponse: [String:Any]?
    var nodeAuthToken: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("_______MADE IT TO NODE_______")
            print(nodeResponse)
            print("__##_#_#_#_#__#_#__#_#_#")
            let nodesArray = nodeResponse!["nodes"] as! NSArray
            print("HELLLOW ISD STRING BELOG")
            let nodesDict = nodesArray[0] as! Dictionary<String,AnyObject>
        print("__________________________________________")
            print(nodesDict["_id"]!)
            print(nodesDict["user_id"]!)
        print("__________________________________________")

        
        let userId = nodesDict["user_id"]! as? String
        let nodeId = nodesDict["_id"]! as? String
        
        let parameters: Parameters = [
                "to": [
                    "type": "DEPOSIT-US",
                    "id": nodeId
                ],
                "amount": [
                    "amount": 20.1,
                    "currency": "USD"
                ],
                "extra": [
                    "ip": "192.168.0.1"
                ]
        ]
        
        // Alamofire headers
        //        let SPGATEWAY = ViewController().valueForAPIKey(named:"GATEWAY")
        let SPUSER = ViewController().valueForAPIKey(named: "USER")
        let SPUSERIP = ViewController().valueForAPIKey(named: "USER-IP")
        
        let userToken = self.nodeAuthToken!["oauth_key"] as! String
        let USER = userToken + SPUSER
        
        let headers: HTTPHeaders = [
            //            "X-SP-GATEWAY": SPGATEWAY,
            "X-SP-USER": USER,
            "X-SP-USER-IP": SPUSERIP
        ]
        
        // creates the url string
        
        let baseString = "https://uat-api.synapsefi.com/v3.1/users/"
        let midString = "/nodes/"
        let endString = "/trans"
        let urlString : String = baseString + userId! + midString + nodeId! + endString
        print("______URL BELOW____________")
        print(urlString)
        
        //API call to create the DEPOSIT-US node
        Alamofire.request(urlString, method:.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
                debugPrint(response)
        }
    }
    
}
