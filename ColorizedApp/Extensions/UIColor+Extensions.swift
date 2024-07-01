//
//  UIColor+Extensions.swift
//  ColorizedApp
//
//  Created by Alex Pesenka on 01/07/24.
//

import UIKit

extension UIColor {
    func getRGBValues() -> (red: Float, green: Float, blue: Float) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (Float(red), Float(green), Float(blue))
    }
}
