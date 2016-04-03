//
//  DoctorPickerViewController.swift
//  MDChat
//
//  Created by Ilia Tikhomirov on 02/04/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit

class DoctorPickerViewController: UIViewController {
    
    @IBOutlet weak var cardPlace: UIView!
    
    func loadViewNib(nibName:String) -> UIView {
        let view = (NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil) as NSArray).firstObject as! UIView
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let card = loadViewNib("DoctorCard")
        card.frame = CGRectMake(0, 0, 325, 235)
        cardPlace.addSubview(card)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
