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
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var userPhoneTextField: UITextField!
    
    var userResponse : [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //display alert messages
    func displayAlert(showMessage:String)-> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: showMessage, preferredStyle: .alert)
            
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
    
    func credentials() -> [String: String] {
        //header for API - Throw this outside when refacoring
        let headers: HTTPHeaders = [
            "X-SP-GATEWAY": "client_id_rAglb9TMLoHRCYZtQe0DdKu25FVaP8W1736XvInB|client_secret_GCDiJFYxcXsW4HOMUtTgqVmZ7dv8ahQp3zbR6NAI",
            "X-SP-USER": "|e83cf6ddcf778e37bfe3d48fc78a6502062fc",
            "X-SP-USER-IP": "2601:646:c202:2e20:6de5:b494:73b6:d98b"
        ]
        return headers
    }
    
    func validate(create: () -> ()){
        //If this breaks when you throw it outside, just keep it in
        //Validate to make sure fields are not empty
        if ((userNameTextField.text == nil || (userNameTextField.text?.isEmpty)!) ||
            (userEmailTextField.text == nil || (userEmailTextField.text?.isEmpty)!) ||
            (userPasswordTextField.text == nil || (userPasswordTextField.text?.isEmpty)!) ||
            (confirmPasswordTextField.text == nil || (confirmPasswordTextField.text?.isEmpty)!) ||
            (userPhoneTextField.text == nil || (userPhoneTextField.text?.isEmpty)!))
        {
            return displayAlert(showMessage: "Please fill in all fields")
            
        //Validate to see if passwords are the same
        } else if ((userPasswordTextField.text?.elementsEqual(confirmPasswordTextField.text!)) != true) {
            return displayAlert(showMessage: "Passwords do not match")
        } else {
            create()
        }
    }
    
    func createUser(cred:()){
        //Throw this outside of the function and make sure to add parameters as a parameter for the function
        //object for the request
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
        
        // Throw this into a secrets folder and gitignore 
        let headers: HTTPHeaders = [
            "X-SP-GATEWAY": "client_id_rAglb9TMLoHRCYZtQe0DdKu25FVaP8W1736XvInB|client_secret_GCDiJFYxcXsW4HOMUtTgqVmZ7dv8ahQp3zbR6NAI",
            "X-SP-USER": "|e83cf6ddcf778e37bfe3d48fc78a6502062fc",
            "X-SP-USER-IP": "2601:646:c202:2e20:6de5:b494:73b6:d98b"
        ]
            //api call
        let urlString : String = "https://uat-api.synapsefi.com/v3.1/users"

        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                let jsonData = response.result.value as! [String:AnyObject]
                //                    print("**********************************")
                //                    print (jsonData["_id"]!,jsonData["legal_names"]!,jsonData["phone_numbers"]!)
                //                    print("**********************************")
            self.userResponse = jsonData
            self.performSegue(withIdentifier: "profileView", sender: self)
        }
    }
    
    //register button that sends data back
    @IBAction func regButtonPressed(_ sender: UIButton) {
        print("Register button pressed *******************")
        validate(create: createUser(cred:) as () -> ())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileView"{
            let destinationVC = segue.destination as! ProfileViewController
            destinationVC.setUserData(data : self.userResponse)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
