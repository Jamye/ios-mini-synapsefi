//
//  profileViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/5/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    @IBAction func docButtonPressed(_ sender: UIButton) {
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var useremailLabel: UILabel!
    @IBOutlet weak var useridLabel: UILabel!
    @IBOutlet weak var userphLabel: UILabel!
    
    var userData : [String:Any]? {
        //execute code when property is set
        didSet {
            print ("This variable has been set")
        }
    }
    
    var userReturnToken: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.displayUserDetails()
        self.oAuthUser()
    }
    
    func setUserData(data: [String:Any]) {
        self.userData = data
    }
    
    // Unwrapping user data
    func displayUserDetails() {
        let username = self.userData!["legal_names"] as! NSArray
        print("printing username")
        print(username)
        let phoneNumber = self.userData!["phone_numbers"] as! NSArray
        let logins = self.userData!["logins"] as! [[String:Any]]
        let userId = self.userData!["_id"] as! String
        
        self.usernameLabel.text = "test"
        self.useridLabel.text = userId
        self.useremailLabel.text = logins[0]["email"] as? String
        self.userphLabel.text = phoneNumber[0] as? String
    }

    // Function that handles request for oAuth Token
    func oAuthUser(){
        
        let userToken = self.userData!["refresh_token"] as! String
        let parameters : Parameters = [
            "refresh_token": userToken
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
        
        //urlstring creation
        let apiUrlString : String = "https://uat-api.synapsefi.com/v3.1/oauth/"
        let createdUserId = self.userData!["_id"] as! String
        let urlString = apiUrlString + createdUserId
    
        //Alamofire call to get oAuth
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
                let jsonData = response.result.value as! [String:AnyObject]
                self.userReturnToken = jsonData
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Prepares data for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addUserDocs"{
            let addDocsDestinationVC = segue.destination as! AddDocsViewController
            addDocsDestinationVC.userRes = userData
            addDocsDestinationVC.userAuthToken = userReturnToken
        }
    }
    
}
