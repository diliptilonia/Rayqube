//
//  ViewController.swift
//  swiftEntryKit
//
//  Created by Dilip Kumar on 21/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

     private let injectedView: UIView
    
    init(with view: UIView) {
        injectedView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    override func loadView() {
//        view = injectedView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = injectedView


    }

 


}

