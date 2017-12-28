//
//  NodesViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/27/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NodesViewController: UITableViewController {
    
    var docResponse: Any?
    var authToken: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("_______MADE IT TO NODE_______")
        print(docResponse!)
        print("__##_#_#_#_#__#_#__#_#_#")
        print(authToken!)
    }
}
