//
//  ViewController.swift
//  newSynProject
//
//  Created by James Ye on 11/30/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController {
    
    //input fields
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var userPhoneTextField: UITextField!
    
    //data object
    var userResponse : [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Displays alert messages
    func displayAlert(showMessage:String)-> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: showMessage, preferredStyle: .alert)
            
            //allows for action within the alert
            let alertAction = UIAlertAction (title: "Ok", style: .default)
            {(action:UIAlertAction!) in
                print("okay button pressed")
                DispatchQueue.main.async
                    {
                        self.dismiss(animated: true, completion:nil)
                }
            }
            alertController.addAction(alertAction)
            self.present(alertController, animated: true,completion: nil)
        }
    }
    
    // Grabs API keys from secret file
    func valueForAPIKey(named keyname:String) -> String {
        
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyname) as! String
        return value
    }
    
    
    // Validates text fields to ensure they are not empty
    func confirmTextFieldsAreFilled()-> Bool{
        if ((userNameTextField.text == nil || (userNameTextField.text?.isEmpty)!) ||
            (userEmailTextField.text == nil || (userEmailTextField.text?.isEmpty)!) ||
            (userPasswordTextField.text == nil || (userPasswordTextField.text?.isEmpty)!) ||
            (confirmPasswordTextField.text == nil || (confirmPasswordTextField.text?.isEmpty)!) ||
            (userPhoneTextField.text == nil || (userPhoneTextField.text?.isEmpty)!))
        {
            displayAlert(showMessage: "Please fill in all fields")
            return false
        } else {
            return true
        }
    }
    
    // Validates password - checks if they are the same
    func confirmPassword()-> Bool {
      if ((userPasswordTextField.text?.elementsEqual(confirmPasswordTextField.text!)) != true) {
            displayAlert(showMessage: "Passwords do not match")
            return false
        } else {
            return true
        }
    }
    
    func createUser(){
        let parameters : Parameters = [
            "logins": [
                ["email" : userEmailTextField.text!]
            ],
            "phone_numbers": [
                userPhoneTextField.text!
            ],
            "legal_names": [
                userNameTextField.text!
            ]
        ]
        
        // Alamofire headers
        let SPGATEWAY = valueForAPIKey(named:"GATEWAY")
        let SPUSER = valueForAPIKey(named: "USER")
        let SPUSERIP = valueForAPIKey(named: "USER-IP")
        
        let headers: HTTPHeaders = [
            "X-SP-GATEWAY": SPGATEWAY,
            "X-SP-USER": SPUSER,
            "X-SP-USER-IP": SPUSERIP
        ]
        
        // Call to synaspefi API
        let urlString : String = "https://uat-api.synapsefi.com/v3.1/users"
        
        if self.confirmPassword() == true && self.confirmTextFieldsAreFilled() == true {
            Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                let jsonData = response.result.value as! [String:AnyObject]
                self.userResponse = jsonData
                self.performSegue(withIdentifier: "profileView2", sender: self) //performs the segue
            }
        } else {
            displayAlert(showMessage: "")
            return
        }
    }
    
    // Register button that sends data to profile
    @IBAction func regButtonPressed(_ sender: UIButton) {
        print("Register button pressed *******************")
        self.createUser()
    }
    
    // Checks if segue should occur - requires extra validation of form fields
    // called immediately before the segue actually happens
    //allow the segue to actually happen
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "profileView" {
            if self.confirmPassword() == true && self.confirmTextFieldsAreFilled() == true {
                return true
            } else {
                displayAlert(showMessage: "Something went wrong please try again")
            }
        }
        return false
    }
    
    //notifies the view controller that the segue is about to be performed
    //called when a segue is about to be performed
    //prepares the data to be passed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileView2"{
            let destinationVC = segue.destination as! ProfileViewController
            destinationVC.setUserData(data: self.userResponse)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

