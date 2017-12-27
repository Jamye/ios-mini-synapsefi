//
//  AddDocsViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/26/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AddDocsViewController: UITableViewController {
    
    var userRes: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameters: Parameters = [
            "documents":
                [["email": "test@test.com",
                  "phone_number": "901.111.1111",
                  "ip":"123.123.123",
                  "name":"Test User",
                  "entity_type":"M",
                  "entity_scope":"Arts & Entertainment",
                  "day":2,
                  "month":5,
                  "year":1989,
                  "address_street":"1 Market St.",
                  "address_city":"SF",
                  "address_subdivision":"CA",
                  "address_postal_code":"94114",
                  "address_country_code":"US"]]
            
        ]
        
        // Alamofire headers
        let SPGATEWAY = ViewController().valueForAPIKey(named:"GATEWAY")
        let SPUSER = ViewController().valueForAPIKey(named: "USER")
        let SPUSERIP = ViewController().valueForAPIKey(named: "USER-IP")
        
        let userToken = self.userRes!["refresh_token"] as! String
        let oauthUser = userToken + SPUSER
        print(oauthUser)
        
        
        let headers: HTTPHeaders = [
            "X-SP-GATEWAY": SPGATEWAY,
            "X-SP-USER": oauthUser,
            "X-SP-USER-IP": SPUSERIP
        ]
        
        // Call to synaspefi API
        let id = self.userRes!["_id"] as! String
        
        let apiString = "https://uat-api.synapsefi.com/v3.1/users/"
        let searchId = id
        
        
        let urlString : String = apiString + searchId
        //        print(urlString)
        
        Alamofire.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
//            debugPrint(response)
//            print("##############################")
//            print (response)
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
}
