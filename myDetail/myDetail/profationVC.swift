//
//  profationVC.swift
//  myDetail
//
//  Created by Dilip Kumar on 31/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit
import Alamofire

class profationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var theTextfield: UITextField!
    let myPickerData = [String](arrayLiteral: "Distributor", "Sub distributor", "Wholesale", "Retailer / tobacconist", "Consumer", "Other")
    var name: String = ""
    var email: String = ""
    var mobileNo: String = ""

    override func viewWillAppear(_ animated: Bool) {
        hideNavi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let thePicker = UIPickerView()
        thePicker.delegate = self
        theTextfield.inputView = thePicker
        showPicker()
        hideKeyBoard()
        print("\(name) \(email) \(mobileNo)")

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        theTextfield.text = myPickerData[row]
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        

        let url = URL(string: "https://diliptilonia.000webhostapp.com/signup.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(name),\(email),\(mobileNo)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()

        
        var st = UIStoryboard(name: "Main", bundle: nil)
        var vc = st.instantiateViewController(withIdentifier: "thanksVC") as! thanksVC
        navigationController?.pushViewController(vc, animated: true)

    }
    


    func showPicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        toolBar.setItems([doneButton, spaceButton, cancel], animated: true)
        theTextfield.inputAccessoryView = toolBar
    }

    @objc func doneClicked() {
        self.view.endEditing(true)
    }

    @objc func cancelClicked() {
//        dismiss(animated: true, completion: nil)
        dismissKeyboard()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
