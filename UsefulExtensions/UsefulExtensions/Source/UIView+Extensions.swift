//
//  UIView+Extensions.swift
//  UsefulExtensions
//
//  Created by Ho, Tsung Wei on 4/19/19.
//  Copyright © 2019 Michael T. Ho. All rights reserved.
//

import UIKit

extension UIView {
    /**
     The getter of the height constraint of the view.
     */
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
    }
    /**
     The getter of the width constraint of the view.
     */
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
    }
    /**
     Initialize a view with background color.
     
     - Parameter color: The background color.
     */
    public convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color
    }
    /**
     Set the corner border of the view.
     
     - Parameter color: The color of the border.
     - Parameter cornerRadius: The corner radius of the view and the border.
     - Parameter borderWidth: The border width.
     */
    public func setCornerBorder(color: UIColor? = nil, cornerRadius: CGFloat = 12.0, borderWidth: CGFloat = 1.5) {
        self.layer.borderColor = color != nil ? color!.cgColor : UIColor.clear.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    /**
     Make circular view.
     
     - Parameter color: The background color of the view.
     - Parameter borderWidth: The border width of the view.
     */
    public func setCircular(color: UIColor? = nil, borderWidth: CGFloat = 5.0) {
        self.setCornerBorder(color: color, cornerRadius: self.frame.width/2, borderWidth: borderWidth)
        self.layoutIfNeeded()
    }
    /**
     Remove all subviews from the current view.
     */
    public func removeSubviews() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    /**
     Blur the border of the current view.
     
     - Parameter shadowRadius: The shadow radius of the view.
     - Parameter inset:        The inset of the bounds of the shadow.
     - Parameter corner:       The corner radius of the border.
     */
    public func setBlurredBorder(shadowRadius: CGFloat = 15.0, inset: CGFloat = 10, corner: CGFloat = 10) {
        let maskLayer = CAGradientLayer()
        maskLayer.frame = self.bounds
        maskLayer.shadowRadius = shadowRadius
        maskLayer.shadowPath = CGPath(roundedRect: self.bounds.insetBy(dx: inset, dy: inset), cornerWidth: corner, cornerHeight: corner, transform: nil)
        maskLayer.shadowOpacity = 0.7
        maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = UIColor.white.cgColor
        self.layer.mask = maskLayer
    }
    /**
     Set the anchors of current view. Make it align to the anchors of other views.
     
     - Parameter top:    The view as a reference for top anchor.
     - Parameter bottom: The view as a reference for bottom anchor.
     - Parameter left:   The view as a reference for left anchor.
     - Parameter right:  The view as a reference for right anchor.
     */
    public func setAnchors(top: UIView? = nil, bottom: UIView? = nil, left: UIView? = nil, right: UIView? = nil) {
        // Align top anchor
        if let top = top {
            self.topAnchor.constraint(equalTo: top.topAnchor).isActive = true
        }
        // Align bottom anchor
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom.bottomAnchor).isActive = true
        }
        // Align left anchor
        if let left = left {
            self.leftAnchor.constraint(equalTo: left.leftAnchor).isActive = true
        }
        // Align right anchor
        if let right = right {
            self.rightAnchor.constraint(equalTo: right.rightAnchor).isActive = true
        }
    }
    /**
     Set layout constraints of top, bottom, left, and right bounds.
     
     - Parameter top:    The view that the current view references as the top view.
     - Parameter tConst: The constant to be applied to the top constraint.
     - Parameter bottom: The view that the current view references as the bottom view.
     - Parameter bConst: The constant to be applied to the bottom constraint.
     - Parameter left:   The view that the current view references as the left view.
     - Parameter lConst: The constant to be applied to the left constraint.
     - Parameter right:  The view that the current view references as the right view.
     - Parameter rConst: The constant to be applied to the right constraint.
     */
    public func setConstraintsToView(top: UIView? = nil, tConst: CGFloat = 0,
                                     bottom: UIView? = nil, bConst: CGFloat = 0,
                                     left: UIView? = nil, lConst: CGFloat = 0,
                                     right: UIView? = nil, rConst: CGFloat = 0) {
        guard let suView = self.superview else { return }
        // Set top constraints if the view is specified.
        if let top = top {
            suView.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: top, attribute: .top, multiplier: 1.0, constant: tConst))
        }
        // Set bottom constraints if the view is specified.
        if let bottom = bottom {
            suView.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: bottom, attribute: .bottom, multiplier: 1.0, constant: bConst))
        }
        // Set left constraints if the view is specified.
        if let left = left {
            if self is UIStackView {
                suView.addConstraint(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: left, attribute: .leading, multiplier: 1.0, constant: lConst))
            } else {
                suView.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: left, attribute: .left, multiplier: 1.0, constant: lConst))
            }
        }
        // Set right constraints if the view is specified.
        if let right = right {
            if self is UIStackView {
                suView.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: right, attribute: .trailing, multiplier: 1.0, constant: rConst))
            } else {
                suView.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: right, attribute: .right, multiplier: 1.0, constant: rConst))
            }
        }
    }
    /**
     Make the specified view (in parameter) to be centered of current view.
     
     - Parameter view: The view to be positioned to the center of current view.
     */
    public func centerSubView(_ view: UIView) {
        self.addConstraints([
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)]
        )
    }
    /**
     Make Square view using layout constraints.
     */
    public func setSquareUsingWidthReference() {
        if self.heightConstraint != nil {
            self.heightConstraint?.isActive = false
        }
        NSLayoutConstraint(item: self, attribute: .height,
                           relatedBy: .equal,
                           toItem: self, attribute: .width,
                           multiplier: 1.0, constant: 0.0).isActive = true
    }
    /**
     The setter of the height constraint of the view.
     
     - Parameter height: The height as constant in CGFloat to set to layout constraint.
     */
    public func setHeightConstraint(_ height: CGFloat) {
        if self.heightConstraint != nil {
            self.heightConstraint?.isActive = false
        }
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height).isActive = true
    }
    /**
     The setter of the width constraint of the view.
     
     - Parameter width: The width as constant in CGFloat to set to layout constraint.
     */
    public func setWidthConstraint(_ width: CGFloat) {
        if self.widthConstraint != nil {
            self.widthConstraint?.isActive = false
        }
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width).isActive = true
    }
    /**
     Align the center of current view to its another view.
     
     - Parameter view: The view as a reference to align the center position.
     */
    public func alignCenter(to view: UIView) {
        guard let superview = self.superview else { return }
        superview.addConstraints([
            NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)]
        )
    }
    /**
     Add subviews and make it prepared for AutoLayout.
     
     - Parameter views: The views to be added as subviews of current view.
     */
    public func addSubViews(_ views: [UIView]) {
        views.forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    /**
     Make self appear as a shadow view.
     
     - Parameter boudns:       The bounds of the shadow view.
     - Parameter cornerRadius: The corner radius of the view.
     - Parameter shadowRadius: The shadow radius.
     */
    public func setAsShadow(bounds: CGRect, cornerRadius: CGFloat = 0.0, shadowRadius: CGFloat = 1) {
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
    }
    /**
     Initialize height contraint, mainly used in pullup views where the view needs to be height 0 initially.
     
     - Parameter attachToView: The view to be adpated this contraint.
     */
    public func getZeroHeightConstraint(attachToView: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: attachToView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)
        return constraint
    }
    /**
     Add gesture recognizers to the view and set the delegate of the gesture recognizers.
     
     - Parameter recognizers: The gesture recognizers to be added to the view.
     - Parameter delegate:    The delegate of the recognizers, typically assigned to the view.
     */
    public func addGestureRecognizers(_ recognizers: [UIGestureRecognizer], _ delegate: UIGestureRecognizerDelegate) {
        recognizers.forEach {
            $0.cancelsTouchesInView = true
            $0.delegate = delegate
            self.addGestureRecognizer($0)
        }
    }
}
