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
    
//    var listItem1 = ["Item1", "Item2", "Item3"]
//
//    var textfieldf: UITextField?
//    var activeData = ["Dilip", "Ajay", "Vikas"]
//    let picker = UIPickerView()

    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNo: UITextField!
    
    var timer = Timer()
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        picker.dataSource = self
//        picker.delegate = self
//        textfield1.delegate = self
//        textfield1.inputView = picker
//        showPicker()
        
        
        hideKeyBoard()
 }
 
    
    @IBAction func submitButton(_ sender: UIButton) {
   
//        let parameters = ["name": nameTF.text, "email": emailTF.text]
//        
//        let urlstring = ""
//        Alamofire.request("https://diliptilonia.000webhostapp.com/signup.php", method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                print(response)
//                
//        }
        

        
        var st = UIStoryboard(name: "Main", bundle: nil)
        var vc = st.instantiateViewController(withIdentifier: "profationVC") as! profationVC
        vc.email = emailTF.text ?? "name"
        vc.name = nameTF.text ?? "name"
        vc.mobileNo = mobileNo.text ?? "mobile"
        navigationController?.pushViewController(vc, animated: true)
        
    }
 
    func showSimpleHUD() {
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.show(in: self.view)
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

}
