//
//  UIApplication+Extensions.swift
//  UsefulExtensions
//
//  Created by Michael Ho on 8/1/19.
//  Updated by Michael Ho on 11/23/20.
//  Copyright © 2019 Ho, Tsungwei. All rights reserved.
//

import UIKit

// MARK: - NSObject
extension NSObject {
    /**
     We assume the AppDelegate exists in the entire life cycle of the app.
     */
    var appDelegate: AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate).unsafelyUnwrapped
    }
}
// MARK: - UIApplication
extension UIApplication {
    /**
     Set the background color of status bar
     
     - Parameter color: the color to be set to the background of status bar.
     */
    public func setStatusBarBackgroundColor(_ color: UIColor) {
        guard let statusBarView = self.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return
        }
        statusBarView.backgroundColor = color
    }
}
// MARK: - UIImageView
extension UIImageView {
    /**
     Change the color of the image.
     
     - Parameter color: The color to be set to the UIImageView.
     */
    public func colored(color: UIColor?) {
        guard let color = color else { return }
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
// MARK: - UISlider
extension UISlider {
    /**
     Set the image of the thumb/knob.
     
     - Parameter image: The image to be set to the thumb/knob.
     */
    public func setThumbImage(_ image: UIImage?) {
        guard let image = image else { return }
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.setThumbImage(image, for: state)
        }
    }
}
// MARK: - NSLayoutConstraint
extension NSLayoutConstraint {
    /**
     Change the constant of the NSLayoutConstraint.
     */
    func changeConstant(_ constant: CGFloat) {
        self.constant = constant
        self.isActive = true
    }
}
// MARK: - StringProtocol
extension StringProtocol {
    
    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
}
// MARK: - UILabel
extension UILabel {
    /**
     Convenience init of theme label with required information
     
     - Parameter title:      The title text of the label.
     - Parameter size:       The size of the title.
     - Parameter bold:       Specify the font of the label.
     - Parameter color:      The text color of the label.
     - Parameter numOfLines: The number of lines to display using the label.
     - Parameter alignment:  Text alignment. Default is set to center.
     */
    public convenience init(title: String, size: CGFloat, bold: Bool = true, color: UIColor, numOfLines: Int = 1, alignment: NSTextAlignment = .center) {
        self.init()
        self.font = bold ? UIFont.systemFont(ofSize: size, weight: .bold) : UIFont.systemFont(ofSize: size, weight: .light)
        self.numberOfLines = numOfLines
        self.text = title
        self.textColor = color
        self.lineBreakMode = .byTruncatingTail
        self.textAlignment = alignment
    }
}
