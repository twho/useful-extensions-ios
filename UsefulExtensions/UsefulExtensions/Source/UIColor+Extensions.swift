//
//  UIColor+.swift
//  UsefulExtensions
//
//  Created by Ho, Tsung Wei on 8/1/19.
//  Copyright © 2019 Ho, Tsungwei. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     Convert RGB value to CMYK value.
     
     - Parameter red: The red value of RGB.
     - Parameter green: The green value of RGB.
     - Parameter blue: The blue value of RGB.
     
     Returns a 4-tuple that represents the CMYK value converted from input RGB.
     */
    private func RGBtoCMYK(
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) -> (
        cyan: CGFloat,
        magenta: CGFloat,
        yellow: CGFloat,
        key: CGFloat
    ) {
        // Base case
        if red == 0, green == 0, blue == 0 {
            return (0, 0, 0, 1)
        }
        var cyan = 1 - red
        var magenta = 1 - green
        var yellow = 1 - blue
        let minCMY = min(cyan, magenta, yellow)
        cyan = (cyan - minCMY) / (1 - minCMY)
        magenta = (magenta - minCMY) / (1 - minCMY)
        yellow = (yellow - minCMY) / (1 - minCMY)
        return (cyan, magenta, yellow, minCMY)
    }
    /**
     Convert CMYK value to RGB value.
     
     - Parameter cyan: The cyan value of CMYK.
     - Parameter magenta: The magenta value of CMYK.
     - Parameter yellow: The yellow value of CMYK.
     - Parameter key: The key/black value of CMYK.
     
     Returns a 3-tuple that represents the RGB value converted from input CMYK.
     */
    private func CMYKtoRGB(
        cyan: CGFloat,
        magenta: CGFloat,
        yellow: CGFloat,
        key: CGFloat
    ) -> (
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) {
        let red = (1 - cyan) * (1 - key)
        let green = (1 - magenta) * (1 - key)
        let blue = (1 - yellow) * (1 - key)
        return (red, green, blue)
    }
    /**
     Get the tint color of the current color.
     */
    public func getColorTint() -> UIColor {
        let ciColor = CIColor(color: self)
        let originCMYK = RGBtoCMYK(red: ciColor.red, green: ciColor.green, blue: ciColor.blue)
        let kVal = originCMYK.key > 0.3 ? originCMYK.key - 0.2 : originCMYK.key + 0.2
        let tintRGB = CMYKtoRGB(cyan: originCMYK.cyan, magenta: originCMYK.magenta, yellow: originCMYK.yellow, key: kVal)
        return UIColor(red: tintRGB.red, green: tintRGB.green, blue: tintRGB.blue, alpha: 1.0)
    }
}
