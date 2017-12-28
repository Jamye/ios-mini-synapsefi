//
//  TransactionViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/28/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class TransactionViewController: UITableViewController {
    
    var nodeResponse: [String:Any]?
    var nodeAuthToken: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                print("_______MADE IT TO NODE_______")
                print(nodeResponse)
                print("__##_#_#_#_#__#_#__#_#_#")
                print(nodeAuthToken)
    }
    
}
