//
//  AddInfoViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/26/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class AddInfoViewController: UITableViewController {
    
    @IBOutlet weak var nameFieldText: UITextField!
    @IBOutlet weak var emailFieldText: UIView!
    @IBOutlet weak var phoneFieldText: UITextField!
    @IBOutlet weak var entityTypeFieldText: UITextField!
    @IBOutlet weak var entityScopeFieldText: UITextField!
    @IBOutlet weak var dobMonthFieldText: UITextField!
    @IBOutlet weak var dobDayFieldText: UITextField!
    @IBOutlet weak var dobYearFieldText: UITextField!
    @IBOutlet weak var addressFieldText: UITextField!
    @IBOutlet weak var cityFieldText: UITextField!
    @IBOutlet weak var stateFieldText: UITextField!
    @IBOutlet weak var zipFieldText: UITextField!
    @IBOutlet weak var countryFieldText: UITextField!
    
    
    
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
        
        let headers: HTTPHeaders = [
            "X-SP-GATEWAY": SPGATEWAY,
            "X-SP-USER": SPUSER,
            "X-SP-USER-IP": SPUSERIP
        ]
        
        // Call to synaspefi API
        let apiString = "https://uat-api.synapsefi.com/v3.1/users/"
        let searchId = "5a41ef7f9f1eef005c304383"
        
        
        let urlString : String = apiString + searchId
        //        print(urlString)
        
        Alamofire.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
                debugPrint(response)
                print("##############################")
                print (response)
        
//            switch response.result {
//            case .failure(let status):
//                // handle errors (including `validate` errors) here
//                print (status)
//                if let statusCode = response.response?.statusCode {
//                    print (statusCode)
////                    self.showLabel.text! = "Something went wrong, please try again"
//                    return
//                }
//            case .success(let value):
//                // handle success here
//                print (value)
////                self.userReturnResponse = value as! [String : Any]
////                self.performSegue(withIdentifier: "showUser", sender: self)
//
//            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
}
