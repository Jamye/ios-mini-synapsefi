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
    
    var userData : Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUserData(data: Any) {
        self.userData = data
        self.displayUserDetails()
    }
    
    func displayUserDetails() {
        usernameLabel.text? = self.userData["legal_names"]
        userIdLabel.text? = String(self.userData["_id"])
        userEmailLabel.text? = self.userData["logins"]["email"]
        userPhoneLabel.text? = String(self.userData["phone_numbers"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
