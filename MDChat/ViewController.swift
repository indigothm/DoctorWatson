//
//  ViewController.swift
//  MDChat
//
//  Created by Ilia Tikhomirov on 02/04/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eyeView: UIImageView!
    var keyboardAdjusted = false
    var lastKeyboardOffset : CGFloat = 0.0
    var tapRecognizer: UITapGestureRecognizer? = nil
    var loadingIsActive: Bool = false
    
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var loadingCross: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureUI()
        
        // Configuring UI
        sendBtn.hidden = true
        questionField.addTarget(self, action:#selector(ViewController.edited), forControlEvents:UIControlEvents.EditingChanged)
        self.cancelBtn.hidden = true
    }
    
    func edited() {
        print("Edited \(questionField.text)")
         sendBtn.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
        self.addKeyboardDismissRecognizer()
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        self.removeKeyboardDismissRecognizer()
    }
    
    @IBAction func cancelDidTouch(sender: AnyObject) {
        questionField.userInteractionEnabled = true
        questionField.text = ""
        loadingIsActive = false
        textLabel.text = "Sure, come again later"
        self.sendBtn.hidden = true
         self.cancelBtn.hidden = true
        
    }
    
    func rotateCross() {
        
       
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.loadingCross.transform = CGAffineTransformRotate(self.loadingCross.transform, CGFloat(M_PI_2))
        }) { (finished) -> Void in
            if self.self.self.loadingIsActive {
            self.rotateCross()
            }
        }
        
        
    }
    
    @IBAction func sendDidTouch(sender: AnyObject) {
        
        if questionField.text == "" {
            textLabel.text = "Please, ask your question"
        } else {
            self.view.endEditing(true)
            self.cancelBtn.hidden = false
            loadingIsActive = true
            textLabel.text = "Looking for a doctor to consult you on this issue"
            self.sendBtn.hidden = true
            questionField.userInteractionEnabled = false
            rotateCross()
            
            performSegueWithIdentifier("showCards", sender: self)
            
        }
        
        
    }
}

extension ViewController {
    
    func addKeyboardDismissRecognizer() {
        self.view.addGestureRecognizer(tapRecognizer!)
    }
    
    func removeKeyboardDismissRecognizer() {
        self.view.removeGestureRecognizer(tapRecognizer!)
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification)
            self.view.superview?.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if keyboardAdjusted == true {
            self.view.superview?.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func configureUI() {
        
        /* Configure tap recognizer */
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleSingleTap(_:)))
        tapRecognizer?.numberOfTapsRequired = 1
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
}


