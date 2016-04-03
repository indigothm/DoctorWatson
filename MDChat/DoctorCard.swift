//
//  DoctorCard.swift
//  MDChat
//
//  Created by Ilia Tikhomirov on 02/04/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import UIKit

protocol CardReplacement {
    func switchView()
}

class DoctorCard: UIView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var spec: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    
    
    func setup(doc: Doctor) {
        spec.text = ""
        name.text = doc.firstName + " " + doc.lastName
        
        for item in doc.specialistIn {
        spec.text! += " " + item
        }
        
        profPic.image = doc.image
        
    }
    
    var delegate: CardReplacement!

    @IBAction func acceptDidTouch(sender: AnyObject) {
        Smooch.show()
    }

    @IBAction func replaceDidTouch(sender: AnyObject) {
        delegate.switchView()
    }
}
