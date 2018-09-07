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

 @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNo: UITextField!
    
    var timer = Timer()
    var counter = 0
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyBoard()
 }
 
    
    @IBAction func submitButton(_ sender: UIButton) {
   
  var st = UIStoryboard(name: "Main", bundle: nil)
        var vc = st.instantiateViewController(withIdentifier: "profationVC") as! profationVC
        vc.email = emailTF.text ?? "email"
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


}
