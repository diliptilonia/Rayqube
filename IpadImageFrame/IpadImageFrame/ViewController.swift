//
//  ViewController.swift
//  IpadImageFrame
//
//  Created by Dilip Kumar on 24/08/18.
//  Copyright © 2018 Dilip Kumar. All rights reserved.
//

import UIKit
import AVFoundation
import JGProgressHUD

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var previewView: UIView!
    var settings: AVCapturePhotoSettings?
    var timer = Timer()
    var counter = 0
    var window: UIWindow?
    @IBOutlet weak var counDownNumber: UILabel!
    

    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        window = UIApplication.shared.keyWindow!
        window?.addSubview(counDownNumber)
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        var input: AVCaptureDeviceInput?
        
        do {
             input = try AVCaptureDeviceInput(device: backCamera)
            //Step 9
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        stillImageOutput = AVCapturePhotoOutput()

        if captureSession.canAddInput(input!) && captureSession.canAddOutput(stillImageOutput) {
            captureSession.addInput(input!)
            captureSession.addOutput(stillImageOutput)
            setupLivePreview()
        }
        
      
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            //Step 13
        }
        
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.previewView.bounds
        }
        
        didTakePhoto((Any).self)

    }
  
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        //Step12
    }

    func didTakePhoto(_ sender: Any) {
        
        settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        }
  }
    
    @objc func timerAction() {
        counter += 1
        if counter > 10 {
            print("reaching in greater than 10")
            showSimpleHUD()
            timer.invalidate()
            stillImageOutput.capturePhoto(with: settings!, delegate: self)
            counDownNumber.isHidden = true

            counter = 0
        } else {
            counDownNumber.text = "\(counter)"
            
        }
    }
    func showSimpleHUD() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.show(in: self.view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            DispatchQueue.main.async {
                print("Working fine till HUD")
            }
        }
    }
}

extension ViewController {
  
}

