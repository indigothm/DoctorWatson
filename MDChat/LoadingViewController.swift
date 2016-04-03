//
//  LoadingViewController.swift
//  MDChat
//
//  Created by Ilia Tikhomirov on 02/04/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var loadingEye: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rotateCross()
        // Do any additional setup after loading the view.
         _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func update() {
        performSegueWithIdentifier("loaded", sender: self)
    }
    
    func rotateCross() {
        
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.loadingEye.transform = CGAffineTransformRotate(self.loadingEye.transform, CGFloat(M_PI_2))
        }) { (finished) -> Void in
           
                self.rotateCross()
            
        }
        
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "loaded") {
            
        let nextViewController = (segue.destinationViewController as! DoctorPickerViewController)
        
        nextViewController.doctorMatch = DoctorSelect.sharedInstance.findADoctor(DoctorSelect.sharedInstance.currentDoc.uniqueID)
        nextViewController.messageText.text = "Updated..."
            
        }
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
