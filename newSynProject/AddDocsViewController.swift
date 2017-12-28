//
//  AddDocsViewController.swift
//  newSynProject
//
//  Created by James Ye on 12/26/17.
//  Copyright © 2017 James Ye. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AddDocsViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var userRes: [String:Any]?
    var userAuthToken: [String:Any]?
    var apiDocResponse: [String:Any]?
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var entityTypeField: UITextField!
    @IBOutlet weak var entityScopeField: UITextField!
    @IBOutlet weak var dobMonthField: UITextField!
    @IBOutlet weak var dobDayField: UITextField!
    @IBOutlet weak var dobYearField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var genderDropDown: UIPickerView!
    @IBOutlet weak var entityScopeDropDown: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Fuctions that handle the pickerView for entity type and entity scope
    var gender = ["M", "F"]
    var eScope = ["Arts & Entertainment","Not Known","Business Services","Organization"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows: Int = gender.count
        if pickerView == genderDropDown {
            countRows = self.gender.count
        }
        else if pickerView == entityScopeDropDown {
            countRows = self.eScope.count
        }
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderDropDown {
            let genderRow = gender[row]
            return genderRow
        }
        else if pickerView == entityScopeDropDown {
            let scopeRow = eScope[row]
            return scopeRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderDropDown {
            self.entityTypeField.text = self.gender[row]
            self.genderDropDown.isHidden = true
        }
        else if pickerView == entityScopeDropDown{
            self.entityScopeField.text = self.eScope[row]
            self.entityScopeDropDown.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.entityTypeField){
            self.genderDropDown.isHidden = false
        }
        else if (textField == self.entityScopeField){
            self.entityScopeDropDown.isHidden = false
        }
    }

    //handles the api call
    func updateUser(){
        var bdayMonth :Int? = Int(dobMonthField.text!)
        var bdayDay :Int? = Int(dobDayField.text!)
        var bdayYear :Int? = Int(dobYearField.text!)
        
        let parameters: Parameters = [
            "documents":
                [["email": emailField.text!,
                  "phone_number": phoneField.text!,
                  "ip":"123.123.123",
                  "name":nameField.text!,
                  "entity_type":entityTypeField.text!,
                  "entity_scope":entityScopeField.text!,
                  "day":bdayDay!,
                  "month":bdayMonth!,
                  "year":bdayYear!,
                  "address_street":addressField.text!,
                  "address_city":cityField.text!,
                  "address_subdivision":stateField.text!,
                  "address_postal_code":zipField.text!,
                  "address_country_code":countryField.text!]]
        ]
        
        // Alamofire headers
        let SPGATEWAY = ViewController().valueForAPIKey(named:"GATEWAY")
        let SPUSER = ViewController().valueForAPIKey(named: "USER")
        let SPUSERIP = ViewController().valueForAPIKey(named: "USER-IP")
        
        let userToken = self.userAuthToken!["oauth_key"] as! String
        let oauthUser = userToken + SPUSER
        
        let headers: HTTPHeaders = [
            "X-SP-GATEWAY": SPGATEWAY,
            "X-SP-USER": oauthUser,
            "X-SP-USER-IP": SPUSERIP
        ]
        
        // creates the url string
        let id = self.userRes!["_id"] as! String
        let apiString = "https://uat-api.synapsefi.com/v3.1/users/"
        let searchId = id
        
        let urlString : String = apiString + searchId
        
        //handles the api call
        Alamofire.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON {
            response in
//                debugPrint(response)
//                print("##############################")
//                print (response)
//                print("##############################")
            switch response.result {
            case .failure(let status):
//                handle errors (including `validate` errors) here
                print (status)
                if let statusCode = response.response?.statusCode {
                    print (statusCode)
                    if statusCode == 409 {
                        self.errorLabel.text! = "Please enter full name with space"
                    } else {
                        self.errorLabel.text! = "Something went wrong, please try again later"
                    }
                    return
                }
            case .success(let value):
                // handle success here
//                print (value)
                let valueResponse = value as? Dictionary<String, AnyObject>
                self.apiDocResponse = valueResponse
                self.errorLabel.text! = "Success"
                self.performSegue(withIdentifier: "nodeView", sender: self)
                return
//                self.userReturnResponse = value as! [String : Any]
//                self.performSegue(withIdentifier: "showUser", sender: self)
            }
        }
    }
    
    //Function for the alert popup
    func showAlert(showMessage:String)-> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: showMessage, preferredStyle: .alert)
            
            //allows for action within the alert
            let alertAction = UIAlertAction (title: "Ok", style: .default)
            {(action:UIAlertAction!) in
                DispatchQueue.main.async
                    {
                        return
                    }
            }
            alertController.addAction(alertAction)
            self.present(alertController, animated: true,completion: nil)
        }
    }
    
    //Function that checks for empty and nil fields
    func confirmTextFieldsAreNotEmpty()-> Bool{
        if ((emailField.text == nil || (emailField.text?.isEmpty)!) ||
            (phoneField.text == nil || (phoneField.text?.isEmpty)!) ||
            (nameField.text == nil || (nameField.text?.isEmpty)!) ||
            (entityTypeField.text == nil || (entityTypeField.text?.isEmpty)!) ||
            (entityScopeField.text == nil || (entityScopeField.text?.isEmpty)!) ||
            (dobMonthField.text == nil || (dobMonthField.text?.isEmpty)!) ||
            (dobDayField.text == nil || (dobDayField.text?.isEmpty)!) ||
            (dobYearField.text == nil || (dobYearField.text?.isEmpty)!) ||
            (addressField.text == nil || (addressField.text?.isEmpty)!) ||
            (cityField.text == nil || (cityField.text?.isEmpty)!) ||
            (stateField.text == nil || (stateField.text?.isEmpty)!) ||
            (zipField.text == nil || (zipField.text?.isEmpty)!) ||
            (countryField.text == nil || (countryField.text?.isEmpty)!))
        {
            showAlert(showMessage: "Please fill in all fields")
            return false
        } else {
            return true
        }
    }
    
    func characterFieldLengthCheck()->Bool{
        if stateField.text!.count != 2 {
            showAlert(showMessage: "State must be two characters long")
            return false
        } else if countryField.text?.count != 2 {
            showAlert(showMessage: "Country must be two characters long")
            return false
        } else if dobMonthField.text?.count != 2 {
            showAlert(showMessage: "Birthday month must be two characters long")
            return false
        } else if dobDayField.text?.count != 2 {
            showAlert(showMessage: "Birthday date must be two characters long")
            return false
        } else if dobYearField.text?.count != 4 {
            showAlert(showMessage: "Birth year must be four characters long")
            return false
        }
        return true
    }

    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        print ("Submit button press @#@#@#@#@#@#@#@#@#@#@")
        if confirmTextFieldsAreNotEmpty() == false || characterFieldLengthCheck() == false {
            showAlert(showMessage: "")
        } else {
            updateUser()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nodeView"{
            let nodeDestinationVC = segue.destination as! NodesViewController
            nodeDestinationVC.docResponse = apiDocResponse
            nodeDestinationVC.authToken = userAuthToken
        }
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
}
