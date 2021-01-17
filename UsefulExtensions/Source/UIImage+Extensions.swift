//
//  UIImage+Extensions.swift
//  UsefulExtensions
//
//  Created by Ho, Tsung Wei on 8/1/19.
//  Copyright © 2019 Ho, Tsungwei. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     The aspect ratio of the current image.
     */
    public var aspectRatio: CGFloat {
        return self.size.width / self.size.height
    }
    /**
     Create color rectangle as image.
     
     - Parameters:
     - color: the color to be created as an UIImage
     - size:  the size of the UIImage, no need to be set when creating
     */
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
        color.setFill()
        UIRectFill(rect)
        // Get the image from the CGRect.
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // Init with the cgImage if it is not nil.
        guard let cgImage = image?.cgImage else { return nil}
        self.init(cgImage: cgImage)
    }
    /**
     Change the color of the image.
     
     - Parameter color: The color to be set to the UIImage.
     
     Returns an UIImage with specified color
     */
    public func colored(_ color: UIColor?) -> UIImage? {
        if let newColor = color {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            // Get current graphics context.
            let context = UIGraphicsGetCurrentContext()!
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.normal)
            // Fill the CGRect with the color specified.
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context.clip(to: rect, mask: cgImage!)
            newColor.setFill()
            context.fill(rect)
            // Get the new image.
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            newImage.accessibilityIdentifier = accessibilityIdentifier
            return newImage
        }
        return self
    }
    /**
     Determine if the current image is the same as another one.
     
     - Parameter anotherImage: The other image to compare to.
     
     - Returns: If two images have the same content.
     */
    func isContentEqualTo(_ anotherImage: UIImage) -> Bool {
        return self.pngData() == anotherImage.pngData()
    }
    /**
     Crop the current image to make it width : height == 3 : 1.
     
     - Return: An image after cropping.
     */
    func cropToWideRatio() -> UIImage? {
        let width = self.size.width
        let height = self.size.height
        let newHeight = width * (1.0/3.0)
        let cropZone = CGRect(x: 0, y: height / 2 - newHeight / 2, width: width, height: newHeight)
        guard let cutImageRef: CGImage = self.cgImage?.cropping(to:cropZone) else {
            return nil
        }
        return UIImage(cgImage: cutImageRef)
    }
}
