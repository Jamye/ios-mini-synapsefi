//
//  NodesViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/27/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NodesViewController: UITableViewController {
    
    var docResponse: [String:Any]?
    var authToken: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("_______MADE IT TO NODE_______")
//        print(docResponse!)
//        print("__##_#_#_#_#__#_#__#_#_#")
//        print(authToken!)
        
        createDepositNode()
    }
    
    func createDepositNode(){
        let parameters: Parameters = [
            "type":"DEPOSIT-US",
            "info":[
                "nickname": "My Checking"
            ]
        ]
        
        // Alamofire headers
        let SPGATEWAY = ViewController().valueForAPIKey(named:"GATEWAY")
        let SPUSER = ViewController().valueForAPIKey(named: "USER")
        let SPUSERIP = ViewController().valueForAPIKey(named: "USER-IP")
        
        let userToken = self.authToken!["oauth_key"] as! String
        let USER = userToken + SPUSER
        
        let headers: HTTPHeaders = [
//            "X-SP-GATEWAY": SPGATEWAY,
            "X-SP-USER": USER,
            "X-SP-USER-IP": SPUSERIP
        ]
        
        // creates the url string
        let id = self.docResponse!["_id"] as! String
        let baseString = "https://uat-api.synapsefi.com/v3.1/users/"
        let endString = "/nodes"
        let urlString : String = baseString + id + endString
        
        print(headers)
        print(urlString)

        
        //API call to create the DEPOSIT-US node
        Alamofire.request(urlString, method:.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
                        debugPrint(response)
                        print("##############################")

//            switch response.result {
//            case .failure(let status):
//        //                handle errors (including `validate` errors) here
//                print (status)
//                if let statusCode = response.response?.statusCode {
//                    print (statusCode)
////                    if statusCode == 409 {
////                        self.errorLabel.text! = "Please enter full name with space"
////                } else {
////                        self.errorLabel.text! = "Something went wrong, please try again later"
////                    }
////                    return
//                }
//            case .success(let value):
//        // handle success here
//                print (value)
//            }
        }
    }
    
    
    
}
