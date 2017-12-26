//
//  UserInfoViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/24/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit

class UserInfoViewController: UITableViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var userInfo: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let logins = self.userInfo!["logins"] as! [[String:Any]]
        let phoneNumber = self.userInfo!["phone_numbers"] as! NSArray
        let userId = self.userInfo!["_id"] as! String
        let userName = self.userInfo!["legal_names"] as! NSArray

        
        emailLabel.text = logins[0]["email"] as? String
        nameLabel.text = userName[0] as? String
        idLabel.text = userId
        phoneLabel.text = phoneNumber[0] as? String
        reload()
        
    }
    
    func reload(){
        self.tableView?.reloadData()
        print ("-----------------------------")
        print (userInfo)
        print ("-----------------------------")

    }
    
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }
}
