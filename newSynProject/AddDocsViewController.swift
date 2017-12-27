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
    var userAuthToken: [String:Any]?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var entityTypeField: UITextField!
    @IBOutlet weak var entityScopeField: UITextField!
    @IBOutlet weak var dobMonthField: UITextField!
    @IBOutlet weak var dobDayField: UITextField!
    @IBOutlet weak var dobYearField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UIView!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

            var bdayMonth :Int? = Int(dobMonthField.text!)
            var bdayDay :Int? = Int(dobDayField.text!)
            var bdayYear :Int? = Int(dobYearField.text!)
            
        let parameters: Parameters = [
            "documents":
                [["email": emailField.text,
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
            
            let userToken = self.userAuthToken!["oauth_key"] as! String
            let oauthUser = userToken + SPUSER
            
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
                debugPrint(response)
                print("##############################")
                print (response)
                print("##############################")
            }
    }
    
    var myDict = [String:String]()
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {

    }


    
    override func viewWillAppear(_ animated: Bool) {
//        print("#@#@#@@#@#@#@#@##@@#@#@#")
//        print(userAuthToken)
//        print("#@#@#@@#@#@#@#@##@@#@#@#")
    }
    
}
