//
//  profileViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/5/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    

    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var userData : [String:Any]? {
        didSet {
            print ("This variable has been set")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUserData(data: [String:Any]) {
        self.userData = data
        if self.userData?.isEmpty != true {
//            self.displayUserDetails()
        }
    }
    
    // Unwrapping user data
//    func displayUserDetails() {
//        let username = self.userData!["legal_names"] as! NSArray
//        let phoneNumber = self.userData!["phone_numbers"] as! NSArray
//        let logins = self.userData!["logins"] as! [[String:Any]]
//        let userId = self.userData!["_id"] as! String
//
        // This is failing due to IBOutlet properties not instantiating - ending up with nil value and cannot unwrap
        
//        usernameLabel.text? = username[0] as! String
//        userIdLabel.text? = userId
//        userEmailLabel.text? = logins[0]["email"]
//        userPhoneLabel.text? = phoneNumber[0]
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
