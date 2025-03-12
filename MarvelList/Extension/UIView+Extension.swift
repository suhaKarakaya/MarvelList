//
//  UIView+Extension.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import UIKit

extension UIView {
    
    @IBInspectable var cRadius: CGFloat {
        get{
            return self.cRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWith: Int {
        get{
            return self.borderWith
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var bordercolor: UIColor {
        get{
            return self.bordercolor
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
}
