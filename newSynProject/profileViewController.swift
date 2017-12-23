//
//  profileViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/5/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.displayUserDetails()
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

//         This is failing due to IBOutlet properties not instantiating - ending up with nil value and cannot unwrap
        
        self.usernameLabel.text = "test"
        self.useridLabel.text = userId
        self.useremailLabel.text = logins[0]["email"] as? String
        self.userphLabel.text = phoneNumber[0] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
