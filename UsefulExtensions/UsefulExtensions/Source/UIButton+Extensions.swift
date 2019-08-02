//
//  UIButton+Extensions.swift
//  UsefulExtensions
//
//  Created by Ho, Tsung Wei on 8/1/19.
//  Copyright © 2019 Ho, Tsungwei. All rights reserved.
//

import UIKit

extension UIButton {
    /**
     Set button image for all button states
     
     - Parameter image: The image to be set to the button.
     */
    public func setImage(_ image: UIImage?) {
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.setImage(image, for: state)
        }
    }
    /**
     Set button title for all button states
     
     - Parameter text: The text to be set to the button title.
     */
    public func setTitle(_ text: String?) {
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.setTitle(text, for: state)
        }
    }
    /**
     Set the spacing between the image and title of the button.
     
     - Parameter spacing: The spacing as CGFloat to be set as gap.
     - Parameter imgPadding: The padding of the image itself.
     */
    public func setTitleImageSpacing(spacing: CGFloat, imgPadding: CGFloat = 0.0) {
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: imgPadding, left: imgPadding, bottom: imgPadding, right: spacing+imgPadding)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
    }
}
