//
//  imagesVC.swift
//  ClickPictuers
//
//  Created by Dilip Kumar on 21/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class imagesVC: UIViewController {

    var name: String?
    var imageOne = UIImage()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = imageOne

        print(namesList)
       
    }
    
    
    

   
    

   

}
