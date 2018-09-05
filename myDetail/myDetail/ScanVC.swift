//
//  ScanVC.swift
//  myDetail
//
//  Created by Dilip Kumar on 31/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//


    import UIKit
    import AVFoundation
    
    class ScanVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @IBOutlet weak var imageView: UIImageView!
     
        
        let imagePicker = UIImagePickerController()
        
        
        @IBAction func loadImageButtonTapped(_ sender: UIButton) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            
            present(imagePicker, animated: true, completion: nil)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            imagePicker.delegate = self
        }
        
        // MARK: - UIImagePickerControllerDelegate Methods
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            self.imagePicker.showsCameraControls = false
            
            print("This functing is calling")
            var  chosenImage = UIImage()
            if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                imageView.contentMode = .scaleAspectFit
                imageView.image = chosenImage
                
                dismiss(animated:true, completion: nil) //5
            }
            //        return chosenImage
        }
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        @IBAction func nextButton(_ sender: UIButton) {
            var st = UIStoryboard(name: "Main", bundle: nil)
            var vc = st.instantiateViewController(withIdentifier: "profationVC") as! profationVC
            navigationController?.pushViewController(vc, animated: true)
        }
}

