//
//  profationVC.swift
//  myDetail
//
//  Created by Dilip Kumar on 31/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import UICheckbox_Swift

class profationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var people: [NSManagedObject] = []
    @IBOutlet weak var checkButton1: UICheckbox!
    
    @IBOutlet weak var yourimageView: UIImageView!
    var myImage = UIImage()
    
    var localPath: String?
    var currentValue = Int()

    @IBOutlet weak var theTextfield: UITextField!
    let myPickerData = [String](arrayLiteral: "Distributor", "Sub distributor", "Wholesale", "Retailer / Tobacconist", "Consumer", "Other")
    var name: String = ""
    var email: String = ""
    var mobileNo: String = ""
    var comingFrom: String = ""
    var industory: String = ""
    var imageToSave: UIImage = UIImage(named: "jp")!
    

    override func viewWillAppear(_ animated: Bool) {
        yourimageView.isHidden = true
        theTextfield.isHidden = true
        yourimageView.image = imageToSave
        hideNavi()
//        UserDefaults.standard.set(id + 1, forKey: "ID")
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
//
//        do {
//            people = try managedContext.fetch(fetchRequest)
//            print("this is row data")
//            print(people)
//            for persondata in people {
//                print(persondata.value(forKey: "personName") ?? "No Name")
//            }
//
//            print("this is after row ")
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
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
        print(industory)
//        incrementIntegerForKey(key: "ID")
        
        var lastIDValue = UserDefaults.standard.integer(forKey: "ID")
        print("LastValue \(lastIDValue)")
        lastIDValue = lastIDValue + 1
        UserDefaults.standard.set(lastIDValue, forKey: "ID")
         currentValue = UserDefaults.standard.integer(forKey: "ID")
        print("CUrrent Value of id \(currentValue)")
        
//        print("updatedValue \())
        if comingFrom == "Form" {
            
            let parameters = [
                "deviceID": deviceID,
                "ID": currentValue,
                "name": String(self.name),
                "email": self.email,
                "mobileNo": self.mobileNo,
                "industory": industory,
                "dataType": self.comingFrom,
                
                ] as [String : Any]
            print("THis is id \(UserDefaults.standard.integer(forKey: "ID"))")
//            industory = self.theTextfield.text!
            let url = "https://diliptilonia.000webhostapp.com/signup.php"
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseString { response in
                print(response.result.value)
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        print(value)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            save()
        } else {
         
            var image = UIImage()
            image = imageToSave
            var convertedData =  convertImageToBase64(image: image)
            print("THis is the converted image in strnig \(convertedData)")
            
            let parameters = [
                "deviceID": deviceID,
                "ID": currentValue,
                "industory": industory,
                "dataType": self.comingFrom,
                "img": convertedData
                ] as [String : Any]
            print("THis is id \(UserDefaults.standard.integer(forKey: "ID"))")
            //            industory = self.theTextfield.text!
            let url = "https://diliptilonia.000webhostapp.com/signup.php"
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseString { response in
                print(response.result.value)
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        print(value)
                    }
                case .failure(let error):
                    print(error)
                }
            }

            
            
            
            
            save()

            
        }
        
        
    
        var st = UIStoryboard(name: "Main", bundle: nil)
        var vc = st.instantiateViewController(withIdentifier: "thanksVC") as! thanksVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func save() {
        print("Reaching in save")
        var imgData = imageToSave.jpegData(compressionQuality: 0.50)!
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person",
                                                in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(name, forKey: "personName")
        person.setValue(email, forKey: "personEmail")
        person.setValue(mobileNo, forKey: "personMobile")
        person.setValue(industory, forKey: "personIndustory")
        person.setValue(deviceID, forKey: "deviceID")
        person.setValue(currentValue, forKey: "id")
        person.setValue(comingFrom, forKey: "dataType")
        person.setValue(imgData, forKey: "image")
        
        do {
            try managedContext.save()
            people.append(person)
            print("Saved Succesfully")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // convert image to base 64 or via versa
    
    func convertImageToBase64(image: UIImage) -> String {
        
        var imageData = image.jpegData(compressionQuality: 0.50)?.base64EncodedData()
        let base64String = imageData?.base64EncodedString()
        
        return base64String!
        
    }
    
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        var decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
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


extension profationVC {
    @IBAction func checkButton(_ sender: UICheckbox) {
       addString(indus: "Distribotor", sender: sender)
    }
    @IBAction func checkButton2(_ sender: UICheckbox) {
        addString(indus: "Sub distributor", sender: sender)
    }
    @IBAction func checkButton3(_ sender: UICheckbox) {
        addString(indus: "Wholesale", sender: sender)
    }
    @IBAction func checkButton4(_ sender: UICheckbox) {
        addString(indus: "Retailer / tobacconist", sender: sender)
    }
    @IBAction func checkButton5(_ sender: UICheckbox) {
        addString(indus: "Consumer", sender: sender)
    }
    @IBAction func checkButton6(_ sender: UICheckbox) {
        addString(indus: "Other", sender: sender)
    }
   
   
//
//    "Distributor", "Sub distributor", "Wholesale", "Retailer / tobacconist", "Consumer", "Other")
    
    func addString(indus: String, sender: UICheckbox) {
        if sender.isSelected == true {
            print("Selected")
            industory = indus + industory
        } else {
            if let range = industory.range(of: indus) {
                industory.removeSubrange(range)
            }        }
    }
    
    func incrementIntegerForKey(key:String) {
        let defaults = UserDefaults.standard
        let inti = defaults.integer(forKey: "ID")
        defaults.set(inti + 1, forKey: "ID")
    }
    
}



//            let params = [
//                "deviceID": deviceID,
//                "ID": id,
//                "industory": industory,
//                "dataType": self.comingFrom,
////                "image": self.myImage
//                ] as [String : Any]
//            Alamofire.upload(multipartFormData:
//                {
//                    (multipartFormData) in
//                    multipartFormData.append(self.myImage!.jpegData(compressionQuality: 0.75)!, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
//
////                    let imageData = myImage.jpegData(compressionQuality: 0.75)
//
//                    for (key, value) in params
//                    {
//                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                    }
//            }, to:"https://diliptilonia.000webhostapp.com/signup.php",headers:nil)
//            { (result) in
//                switch result {
//                case .success(let upload,_,_ ):
//                    upload.uploadProgress(closure: { (progress) in
//                        //Print progress
//                    })
//                    upload.responseString
//                        { response in
//                            //print response.result
//                            if response.result.value != nil
//                            {
//                                print(response.result.value)
////                                let dict : = response.result.value
////                                let status = dict.value(forKey: "status")as! String
////                                if status=="1"
////                                {
////                                    print("DATA UPLOAD SUCCESSFULLY")
////                                }
//                            }
//                    }
//                case .failure(let encodingError):
//                    break
//                }
//            }


//let imageData = image.jpegData(compressionQuality: 0.75)


//                        let parameters = [
//                            "deviceID": deviceID,
//                            "ID": id,
//                            "industory": industory,
//                            "dataType": self.comingFrom,
//            //                "image": self.myImage
//                            ] as [String : Any]
//            let parameters = ["name": rname] //Optional for extra parameter



//            let parameters = [
//                "file_name": "swift_file.jpeg"
//            ]
//
//            Alamofire.upload(multipartFormData: { (multipartFormData) in
//                multipartFormData.append(self.imageToSave.jpegData(compressionQuality: 0.75)!, withName: "photo_path", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//                for (key, value) in parameters {
//                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                }
//            }, to:"https://diliptilonia.000webhostapp.com/signup.php")
//            { (result) in
//                switch result {
//                case .success(let upload, _, _):
//
//                    upload.uploadProgress(closure: { (progress) in
//                        //Print progress
//                    })
//
//                    upload.responseJSON { response in
//                        //print response.result
//                    }
//
//                case .failure(let encodingError):
//                    print("Error in responce")
//                }
//            }












//                        var imgData = imageToSave.jpegData(compressionQuality: 0.50)!
//
//            let parameters = [
//                            "deviceID": deviceID,
//                            "ID": id,
//                            "industory": industory,
//                            "dataType": self.comingFrom,
//            //                "imgData": imageData ?? "No Image"
//                            ] as [String : Any]
//
//
//             let imageToUploadURL = Bundle.main.url(forResource: "tree", withExtension: "png")
//
//                // Server address (replace this with the address of your own server):
//                let url = "https://diliptilonia.000webhostapp.com/signup.php2we"
//
//                // Use Alamofire to upload the image
//                Alamofire.upload(
//                        multipartFormData: { multipartFormData in
//                            multipartFormData.append(imgData, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
//                            for (key, val) in parameters {
//                                                                    multipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                                    }
//                    },
//                        to: url,
//                        encodingCompletion: { encodingResult in
//                            switch encodingResult {
//                            case .success(let upload, _, _):
//                                 upload.responseJSON { response in
//                                    if let jsonResponse = response.result.value as? [String: Any] {
//                                        print(jsonResponse)
//                                     }
//                                }
//                            case .failure(let encodingError):
//                                 print(encodingError)
//                             }
//                     }
//                     )
//




//            var imgData = imageToSave.jpegData(compressionQuality: 0.50)!
//            let parameters = [
//                "deviceID": deviceID,
//                "ID": id,
//                "industory": industory,
//                "dataType": self.comingFrom,
////                "imgData": imageData ?? "No Image"
//                ] as [String : Any]//Optional for extra parameter
//
//                        Alamofire.upload(multipartFormData:
//                            {
//                                (multipartFormData) in
//                                multipartFormData.append(imgData, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
//
//            //                    let imageData = myImage.jpegData(compressionQuality: 0.75)
//
//                                for (key, value) in parameters
//                                {
//                                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                                }
//                        }, to:"https://diliptilonia.000webhostapp.com/signup.php",headers:nil)
//                        { (result) in
//                            switch result {
//                            case .success(let upload,_,_ ):
//                                upload.uploadProgress(closure: { (progress) in
//                                    //Print progress
//                                })
//                                upload.responseJSON
//                                    { response in
//                                        //print response.result
//                                        if response.result.value != nil
//                                        {
//                                            print("WOrking image upload")
//                                            print(response.result.value)
//            //                                let dict : = response.result.value
//            //                                let status = dict.value(forKey: "status")as! String
//            //                                if status=="1"
//            //                                {
//            //                                    print("DATA UPLOAD SUCCESSFULLY")
//            //                                }
//                                        }
//                                }
//                            case .failure(let encodingError):
//                            print("DIn't get responce")
//                            }
//                        }
//
