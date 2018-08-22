//
//  clickPicsPage.swift
//  ClickPictuers
//
//  Created by Dilip Kumar on 21/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit
import AVFoundation

public var namesList = ["Dilip", "Ajay", "Deepak"]
public var imageTaken = UIImage()

class clickPicsPage:UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    let picker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func shootPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .scaleAspectFit //3
        myImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

