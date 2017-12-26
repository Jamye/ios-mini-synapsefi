//
//  FindViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/23/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class FindViewController: UIViewController {
 
    var userReturnResponse : [String:Any] = [:]
    
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var userIdLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func findButtonPressed(_ sender: UIButton) {
        print ("find button was pressed")
        getUserInfo()

    }
    
    func getUserInfo() {
        let parameters: Parameters = [
            "user_id": userIdLabel.text!
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
        let searchId = userIdLabel.text!
        
        let urlString : String = apiString + searchId
//        print(urlString)
        
        Alamofire.request(urlString, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON {
            response in
            switch response.result {
                case .failure:
                    // handle errors (including `validate` errors) here
                    if let statusCode = response.response?.statusCode {
                        print (statusCode)
                        self.showLabel.text! = "Something went wrong, please try again"
                        return
                  }
                case .success(let value):
                    // handle success here
                    self.userReturnResponse = value as! [String : Any]
                    self.performSegue(withIdentifier: "showUser", sender: self)
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUser"{
            let userDestinationVC = segue.destination as! UserInfoViewController
            userDestinationVC.userInfo = userReturnResponse
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
}

