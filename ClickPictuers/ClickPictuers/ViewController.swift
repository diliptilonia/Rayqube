//
//  ViewController.swift
//  ClickPictuers
//
//  Created by Dilip Kumar on 21/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func nextPageButton(_ sender: UIButton) {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "clickPicsPage") as! clickPicsPage
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

}

