//
//  ViewController.swift
//  InstagridP4
//
//  Created by ONIZUKA  on 02/11/2020.
//  Copyright © 2020 ONIZUKA . All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate {
    
        var swipeGestureIdentification: UISwipeGestureRecognizer?
    
    // The variable used to pick an image from the user's photo library.
           private var   buttonTouched = UIButton()
           private let imageChoice = UIImagePickerController()
           
    
      //MARK: -Outlet Connection
        
        
        @IBOutlet weak var topLeftButton: UIButton!
        @IBOutlet weak var topRightButton: UIButton!
        @IBOutlet weak var bottomLeftButton: UIButton!
        @IBOutlet weak var bottomRightButton: UIButton!
        
        @IBOutlet weak var Layout1Button: UIButton!
        @IBOutlet weak var Layout2Button: UIButton!
        @IBOutlet weak var Layout3Button: UIButton!
        
        @IBOutlet weak var swipeUpOrLeft: UILabel!
    
        @IBOutlet weak var mainView: UIView!
    
        
    //MARK:- viewDidLoad
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        Layout2Button.isSelected = true
        bottomLeftButton.isHidden = true
        
        imageChoice.delegate = self
        
        swipeGestureIdentification = UISwipeGestureRecognizer(target: self, action: #selector(swipeOutMainBlueView(sender:)))
        
        guard let swipeGesture = swipeGestureIdentification else {fatalError()}
        mainView.addGestureRecognizer(swipeGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(swipeOrder), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    
    //MARK: -Image insertion
    
    
    @IBAction func imageButton(_ sender: UIButton) {
        buttonTouched = sender
        takePhoto()
        
    }
    
    func takePhoto() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            imageChoice.delegate = self
            imageChoice.sourceType = .photoLibrary
            imageChoice.allowsEditing = false
            present(imageChoice, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { imageInsertion(pickedImage) }
        
    }
    
    func imageInsertion(_ image: UIImage) {
        buttonTouched.contentMode = .scaleAspectFit
        buttonTouched.setImage(image, for: UIControl.State.normal)
    }
    
    
    //MARK: -Swipe Gesture for Sharing
    
    
    @objc func swipeOrder() {
        if UIDevice.current.orientation == .portrait {
            swipeGestureIdentification?.direction = .up
        } else if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureIdentification?.direction = .left
        }
    }
}

