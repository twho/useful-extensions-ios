//
//  UIStackView+Extensions.swift
//  UsefulExtensions
//
//  Created by Ho, Tsung Wei on 8/1/19.
//  Copyright © 2019 Ho, Tsungwei. All rights reserved.
//

import UIKit

extension UIStackView {
    /**
     Convenience constructer of UIStackView, which assigns the properties all at once.
     */
    convenience init(arrangedSubviews: [UIView]? = nil, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, spacing: CGFloat) {
        if let arrangedSubviews = arrangedSubviews {
            self.init(arrangedSubviews: arrangedSubviews)
        } else {
            self.init()
        }
        (self.axis, self.spacing, self.distribution) = (axis, spacing, distribution)
    }
    /**
     Remove all subviews in the UIStackView.
     */
    public func removeAllSubviews() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
        self.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
