//
//  thanksVC.swift
//  myDetail
//
//  Created by Dilip Kumar on 04/09/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit

class thanksVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    DispatchQueue.main.async {
                        //                self.navigationController?.dismiss(animated: true, completion: nil)
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                    }
                }

    }
    

 

}
