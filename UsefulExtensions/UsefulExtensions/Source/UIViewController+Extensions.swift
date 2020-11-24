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
                                 titleColor: UIColor = .white, backgroundColor: UIColor = .black) -> UINavigationBar {
        // Accomodate iOS 13 API for status bar height.
        let window = UIApplication.shared.windows[0]
        var statusBarHeight: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            statusBarHeight = window.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        // Apply safe areas to the navigation bar.
        statusBarHeight = max(statusBarHeight, window.safeAreaInsets.top)
        // Set up navigation bar.
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: 50.0))
        navbar.barTintColor = backgroundColor
        navbar.backgroundColor = backgroundColor
        navbar.isTranslucent = false
        // Set up navigation bar items.
        let navItem = UINavigationItem()
        let titleLabel = UILabel(title: title, size: 20.0, color: .white)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = titleColor
        navbar.tintColor = titleColor
        navItem.titleView = titleLabel
        navItem.leftBarButtonItem = leftBarItem
        navItem.rightBarButtonItem = rightBarItem
        navbar.items = [navItem]
        // Set up background view
        let view = UIView()
        view.backgroundColor = backgroundColor
        
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
        self.modalPresentationStyle = .custom
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIViewController: UIViewControllerTransitioningDelegate {
    /**
     Go to other view controllers with custom animation.
     
     - Parameter view: The destination view controller.
     */
    public func goToView(_ view: UIViewController, completion: (() -> Void)? = nil) {
        view.transitioningDelegate = self
        view.modalPresentationStyle = .custom
        self.present(view, animated: true, completion: nil)
    }
    /**
     Load view with animation. The background will be loaded before the primary views.
     
     - Parameter loadFunc: The loading function used to load primary views.
     */
    public func loadViewWithAnimation(loadFunc: @escaping (()->())) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.transitionCrossDissolve], animations: {
            self.view.backgroundColor = .white
        }, completion: { _ in
            loadFunc()
        })
    }
}
