//
//  LandScape.swift
//  Instagrid
//
//  Created by ONIZUKA  on 30/10/2020.
//  Copyright © 2020 ONIZUKA . All rights reserved.
//

import Foundation
import UIKit


//MARK: - Transfrom mainBlueView to UIImage object


extension UIView {
    
    var image : UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        
        let image = renderer.image { i  in
            
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
    }
}
