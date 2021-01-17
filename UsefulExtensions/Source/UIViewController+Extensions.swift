//
//  UIViewController+Extensions.swift
//  UsefulExtensions
//
//  Created by Michael Ho on 4/19/19.
//  Updated by Michael Ho on 11/23/20.
//  Copyright © 2019 Michael T. Ho. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     A boolean indicate whether the view is currently visible.
     */
    public var isViewVisible: Bool {
        return self.isViewLoaded && self.view.window != nil
    }
    /**
     Get a cell reuse identifier tied with the class name.
     */
    public var cellReuseIdentifier: String {
        return String(describing: self) + "TableViewCell"
    }
    /**
     Hide keyboard when tapping the parent view under current view controller.
     */
    public func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    /**
     Dismiss keyboard.
     */
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    /**
     Add moving listeners to the parent view under current view controller.
     */
    public func addKeyboardViewMoveListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    /**
     Create a navigation bar.
     
     - Parameter title:           The title to display at the center of navigation bar.
     - Parameter leftBarItem:     The left navigation bar button item.
     - Parameter rightBarItem:    The right navigation bar button item.
     - Parameter titleColor:      The title color of the navigation bar.
     - Parameter backgroundColor: The background color of the navigation bar.
     
     - Returns: A navigation bar that is added to the view controller.
     */
    public func addNavigationBar(title: String, leftBarItem: UIBarButtonItem? = nil, rightBarItem: UIBarButtonItem? = nil,
                                 titleColor: UIColor = .label, backgroundColor: UIColor = .secondarySystemBackground) -> UINavigationBar {
        // Accomodate iOS 13 API for status bar height.
        let window = UIApplication.shared.windows[0]
        var statusBarHeight = window.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        // Apply safe areas to the navigation bar.
        statusBarHeight = max(statusBarHeight, window.safeAreaInsets.top)
        // Set up navigation bar.
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: 50.0))
        navbar.barTintColor = backgroundColor
        navbar.backgroundColor = backgroundColor
        navbar.isTranslucent = false
        // Remove lines in navigation bar
        navbar.shadowImage = UIImage()
        // Set up navigation bar items.
        let navItem = UINavigationItem()
        let titleLabel = UILabel(title: title, size: 20.0, color: titleColor)
        titleLabel.adjustsFontSizeToFitWidth = true
        navbar.tintColor = titleColor
        navItem.titleView = titleLabel
        navItem.leftBarButtonItem = leftBarItem
        navItem.rightBarButtonItem = rightBarItem
        navbar.items = [navItem]
        // Set up background view
        let view = UIView(color: backgroundColor)
        // Navigation is well defined, no need to set translating auto mask
        self.view.addSubview(navbar)
        self.view.addSubViews([view])
        view.setConstraintsToView(top: self.view, bottom: navbar, bConst: -navbar.frame.height, left: self.view, right: self.view)
        
        return navbar
    }
    /**
     Dismiss current view.
     */
    @objc public func backToPreviousVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func presentInFullscreen(_ vc: UIViewController, _ animated: Bool = true) {
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    /**
     Load view with animation. The background will be loaded before the primary views.
     
     - Parameter function:   The function to rnu within the animation block.
     - Parameter completion: The completion handler.
     */
    public func runInAnimation(_ function: @escaping (()->()), completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            function()
        }, completion: completion)
    }
}
