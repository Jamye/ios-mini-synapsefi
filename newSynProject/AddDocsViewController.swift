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
    @IBOutlet weak var stateField: UIView!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    
    @IBOutlet weak var genderDropDown: UIPickerView!
    @IBOutlet weak var entityScopeDropDown: UIPickerView!
    
    
    //picker for gender
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var myDict = [String:String]()
    
    func updateUser(){
        var bdayMonth :Int? = Int(dobMonthField.text!)
        var bdayDay :Int? = Int(dobDayField.text!)
        var bdayYear :Int? = Int(dobYearField.text!)
        
        let parameters: Parameters = [
            "documents":
                [["email": emailField.text,
                  "phone_number": phoneField.text,
                  "ip":"123.123.123",
                  "name":nameField.text,
                  "entity_type":entityTypeField.text!,
                  "entity_scope":entityScopeField.text!,
                  "day":bdayDay,
                  "month":bdayMonth,
                  "year":bdayYear,
                  "address_street":addressField.text,
                  "address_city":cityField.text,
                  "address_subdivision":cityField.text,
                  "address_postal_code":zipField.text,
                  "address_country_code":countryField.text]]
            
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
        
        // Call to synaspefi API
        let id = self.userRes!["_id"] as! String
        
        let apiString = "https://uat-api.synapsefi.com/v3.1/users/"
        let searchId = id
        
        
        let urlString : String = apiString + searchId
        //        print(urlString)
        
        Alamofire.request(urlString, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            debugPrint(response)
            print("##############################")
            print (response)
            print("##############################")
        }
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        print("#@#@#@@#Excliam@#@#@#@##@@#@#@#")
        print (entityTypeField.text!)
        print("#@#@#@@#@#@Question#@#@##@@#@#@#")
        print (entityTypeField.text! as String)

        updateUser()
    }


    
    override func viewWillAppear(_ animated: Bool) {
//        print("#@#@#@@#@#@#@#@##@@#@#@#")
//        print(userAuthToken)
//        print("#@#@#@@#@#@#@#@##@@#@#@#")
    }
    
}
