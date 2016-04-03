//
//  ViewController.swift
//  MDChat
//
//  Created by Ilia Tikhomirov on 02/04/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit
import WatsonDeveloperCloud

class ViewController: UIViewController {
    
    var theDoctor : Doctor = Doctor.init(uniqueID: "fake", firstName: "fake", lastName: "fake", emailAddress: "fake", password: "fake", specialistIn: ["fake"], image: UIImage(named: "Doctor1")!)
   
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showCards") {
            
            let nextViewController = (segue.destinationViewController as! DoctorPickerViewController)
            nextViewController.incomingMessageText = questionField.text!
            nextViewController.doctorMatch = theDoctor
            
        
        }
        
        }
    
    func update() {
        performSegueWithIdentifier("showCards", sender: self)
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
            
            //Temporary Feature
            
          //   _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: false)
            
            let alchemyLanguageInstance = AlchemyLanguage(apiKey: "93a0b64d4a104eb622e7a54db938c4cccaedd14f")
            let keywordsParam = AlchemyLanguage.GetKeywordsParameters.init()

            
            alchemyLanguageInstance.getRankedKeywords(requestType: .Text, html: nil, url: nil, text: questionField.text!, completionHandler: {(error: NSError, returnValue: WatsonDeveloperCloud.Keywords) -> Void in
                print("entered completion")
                print(returnValue.language)
                print(returnValue.keywords?.count)
                for(var i = 0; i < returnValue.keywords?.count; i++){
                    DoctorSelect.sharedInstance.theKeywords.append(returnValue.keywords![i])
                    print(returnValue.keywords![i])
                }
                self.theDoctor = DoctorSelect.sharedInstance.findADoctor("-1")
                DoctorSelect.sharedInstance.currentDoc = self.theDoctor
                print(self.theDoctor.uniqueID)
                self.performSegueWithIdentifier("showCards", sender: self)
                
            })
            
            
            
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


