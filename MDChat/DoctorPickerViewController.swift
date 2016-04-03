//
//  DoctorPickerViewController.swift
//  MDChat
//
//  Created by Ilia Tikhomirov on 02/04/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class DoctorPickerViewController: UIViewController, CardReplacement {
    
    @IBOutlet weak var cardPlace: UIView!
    @IBOutlet weak var messageText: UILabel!
    var doctorMatch: Doctor!
    
    var incomingMessageText: String = "Loading"
    
    func loadViewNib(nibName:String) -> UIView {
        let view = (NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil) as NSArray).firstObject as! UIView
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let card = loadViewNib("DoctorCard") as! DoctorCard
        card.delegate = self
        card.setup(doctorMatch)
        card.frame = CGRectMake(0, 0, 325, 235)
        cardPlace.addSubview(card)
        messageText.text = incomingMessageText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchView() {
         performSegueWithIdentifier("loading", sender: self)
    }
    
    @IBAction func closeSessionDidTouch(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
