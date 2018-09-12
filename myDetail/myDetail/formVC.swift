//
//  formVC.swift
//  myDetail
//
//  Created by Dilip Kumar on 31/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit
import JGProgressHUD
import Alamofire


class formVC: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    
 @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNo: UITextField!
    
    var timer = Timer()
    var counter = 0
    
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyBoard()
 }
 
    
    @IBAction func submitButton(_ sender: UIButton) {
        guard nameTF.text != "" else {
            errorLabel.isHidden = false
            print("Email TextField is empty")
            errorLabel.text = "Name text field is empty"
            return
        }
       
        
        guard emailTF.text != "" && emailTF.text?.isEmail == true else {
            errorLabel.isHidden = false
            print("Name text field is empty")
            errorLabel.text = "Invalide Email ID"
            return
        }
        isValidEmail(testStr: emailTF.text!)
        
        guard mobileNo.text != "" && mobileNo.text?.validPhoneNumber == true else {
            errorLabel.isHidden = false
            print("Name text field is empty")
            errorLabel.text = "Invalide Phone No"
            return
        }
        validate(value: mobileNo.text!)
        errorLabel.isHidden = true
      
   
  var st = UIStoryboard(name: "Main", bundle: nil)
        var vc = st.instantiateViewController(withIdentifier: "profationVC") as! profationVC
        vc.email = emailTF.text ?? "email"
        vc.name = nameTF.text ?? "name"
        vc.mobileNo = mobileNo.text ?? "mobile"
        vc.comingFrom = "Form"
        navigationController?.pushViewController(vc, animated: true)
        
    }
 
    func showSimpleHUD() {
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.show(in: self.view)
    }

    @IBAction func backButton(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)

    }
    
}

extension UIViewController {
    public func hideKeyBoard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Form Validation checking
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }


}

extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                
                if(self.characters.count>=6 && self.characters.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    public var validPhoneNumber:Bool {
        let types:NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, characters.count)).first?.phoneNumber {
            return match == self
        }else{
            return false
        }
    }
}
