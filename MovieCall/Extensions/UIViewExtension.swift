//
//  UIViewExtension.swift
//  MovieCall
//
//  Created by Juanito Martinon on 9/28/23.
//

import Foundation
import UIKit


var colorcashe = NSCache<AnyObject, AnyObject>()

extension UIView {
    func addGradientToViewWithCornerRadiusAndShadow(radius:CGFloat,firstColor:UIColor,secondColor:UIColor,locations:[CGFloat]){
        for layer in (self.layer.sublayers ?? []){
            if let layer1 = layer as? CAGradientLayer{
                layer1.removeFromSuperlayer()
            }
        }
        let gradient = CAGradientLayer()
        var rect = self.bounds
        rect.size.width = self.frame.width
        gradient.frame = rect
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = locations as [NSNumber]
        gradient.startPoint = CGPoint.init(x: 0, y: 0)
        gradient.endPoint = CGPoint.init(x: 0, y: 1)
        gradient.cornerRadius = radius
        gradient.shadowRadius = 2
        gradient.shadowColor = UIColor.lightGray.cgColor
        gradient.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        gradient.shadowOpacity = 0.5
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    
    
    
    // MARK: - ADDS GRADIANT
    
    func somegradient(firstColor: CGColor, secondColor: CGColor, thirdColor: CGColor, fourhColor: CGColor) {
        
        if let gradientLayer = (self.layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
            gradientLayer.removeFromSuperlayer()
        }
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.type = .axial
        gradientLayer.colors = [
            firstColor, secondColor, thirdColor, fourhColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
// MARK: - ADDS SOLID BACKGROUND BUT NOT WORKING
    
    func settingBackground(onecolor: UIColor) {
        if  ((self.backgroundColor?.isEqual(UIColor.blue)) == true) {
            self.backgroundColor = onecolor
        } else {
           print("ok")
        }
    
    }
    
    
}
