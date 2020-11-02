//
//  ViewControllerExtension.swift
//  Instagrid
//
//  Created by ONIZUKA  on 30/10/2020.
//  Copyright © 2020 ONIZUKA . All rights reserved.
//

import Foundation
import UIKit

extension ViewController : UINavigationControllerDelegate {
    
    
    //MARK: -Label Portrait/Landscape modification
    
    
    @IBAction func Layout1ButtonTouched(_ sender: Any) {
        if (Layout1Button.currentImage == nil) {
            removeButtonsImages()
            bottomRightButton.isEnabled = true;
            bottomRightButton.isHidden = false;
            Layout1Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
            topRightButton.isEnabled = true;
            topRightButton.isHidden = true;
            bottomLeftButton.isHidden = false;
        }
    }
    
    @IBAction func Layout2ButtonTouched(_ sender: Any) {
        if (Layout2Button.currentImage == nil) {
            removeButtonsImages()
            topRightButton.isEnabled = true;
            topRightButton.isHidden = false;
            Layout2Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
            bottomRightButton.isEnabled = true;
            bottomRightButton.isHidden = false;
            bottomLeftButton.isHidden = true;
            
        }
    }
    
    @IBAction func Layout3ButtonTouched(_ sender: Any) {
        if (Layout3Button.currentImage == nil) {
            removeButtonsImages()
            topRightButton.isEnabled = true;
            bottomRightButton.isEnabled = true;
            topRightButton.isHidden = false;
            bottomRightButton.isHidden = false;
            bottomLeftButton.isHidden = false;
            Layout3Button.setImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        }
    }
    
    func removeButtonsImages() {
        Layout1Button.setImage(nil, for: UIControl.State.normal)
        Layout2Button.setImage(nil, for: UIControl.State.normal)
        Layout3Button.setImage(nil, for: UIControl.State.normal)
    }
    
    
    //MARK: -Swipe Gesture for Sharing
    
    
    @objc func swipeOutMainBlueView(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .up :
                swipeUp(gesture: sender)
            case .left :
                swipeLeft(gesture: sender)
            default :
                break
            }
        }
    }
    
    fileprivate func swipeUp(gesture: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.mainView.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        }, completion: {
            (true) in
            self.shareView()
        })
    }
    
    fileprivate func swipeLeft(gesture: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.mainView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }, completion: {
            (true) in
            self.shareView()
        })
    }
    
    
    //MARK: -Share Sheet Animation + reset mainBlueView after sharing
    
    
    fileprivate func shareView() {
        
        let items = [mainView.image]
        
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityController, animated: true)
        
        activityController.completionWithItemsHandler = { activity, sucess, items, error in
            
            UIView.animate(withDuration: 1, animations: {
                self.mainView.transform = .identity }
            )}
        }
    }
