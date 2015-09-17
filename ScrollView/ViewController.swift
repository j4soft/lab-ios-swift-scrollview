//
//  ViewController.swift
//  ScrollView
//
//  Created by Jack on 16/09/15.
//  Copyright © 2015 ACME. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        setupTextFieldsShouldReturn()
        hideKeyboardOnTouch()
    }

    // Setup text fields delegate to view controller.
    func setupTextFieldsShouldReturn() {
        for subview in contentView.subviews {
            if subview is UITextField {
            let textField = subview as! UITextField
            textField.delegate = self
            }
        }
    }
    
    // Hides keyboard when pressing return key.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Setup tap gesture
    func hideKeyboardOnTouch() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    // Hide keyboard (called when tapping outside text fields).
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Define notifications when keyboard will be shown or hidden.
    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
                selector: "keyboardWillBeHidden:",
                name: UIKeyboardWillHideNotification,
                object: nil)
    }
    
    // Scrolls scroll view by the height of the keyboard.
    func keyboardWillBeShown(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    // Reset scroll view scrolling when keyboard hides.
    func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @IBAction func register(sender: AnyObject) {
        for subview in contentView.subviews {
            if subview is UITextField {
                let textField = subview as! UITextField
                NSLog("value: \(textField.text)")
            }
        }
    }
}

