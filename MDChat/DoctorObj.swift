//
//  DoctorObj.swift
//  TestWatson
//
//  Created by Alex Dejeu on 4/2/16.
//  Copyright © 2016 DoGoodTechnology. All rights reserved.
//

import Foundation
import UIKit

class Doctor {
    var uniqueID : String = "101"
    var firstName : String = "First"
    var lastName  : String = "Last"
    var emailAddress: String = "email@email.com"
    var password : String = "password"
    
    var specialistIn: [String] = ["generalCare"]
    
    var image: UIImage
    
    
    
    init(uniqueID: String, firstName: String, lastName : String, emailAddress: String, password: String, specialistIn: [String], image: UIImage) {
        self.uniqueID = uniqueID
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.password = password
        self.specialistIn = specialistIn
        self.image = image
    }
}