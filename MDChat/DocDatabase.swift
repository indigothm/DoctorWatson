//
//  DocDatabase.swift
//  TestWatson
//
//  Created by Alex Dejeu on 4/2/16.
//  Copyright © 2016 DoGoodTechnology. All rights reserved.
//

import Foundation
import UIKit

class DoctorDatabase{
 
    var database: [Doctor] = []

//    theDocID = findDoctorOfType("Dermatologists")
//    theDocID = findDoctorOfType("Gastroenterology")
//    theDocID = findDoctorOfType("Neurologists")
//    theDocID = findDoctorOfType("Obstetricians")
//    theDocID = findDoctorOfType("Ophthalmologists")
//    theDocID = findDoctorOfType("Psychiatrist")
    init(){
      //Create doctors
        database.append(Doctor(uniqueID : "1", firstName: "David", lastName: "Robertson", emailAddress: "DR@gmail.com", password: "password", specialistIn: ["Sports", "General Care"], image: UIImage(named: "Doctor1")!))
        
        database.append(Doctor(uniqueID : "2", firstName: "Matt", lastName: "Von Wrank", emailAddress: "MV@gmail.com", password: "password", specialistIn: ["Psychiatrist"], image: UIImage(named: "Doctor2")!))
        
        database.append(Doctor(uniqueID : "3", firstName: "Vinny", lastName: "Shah", emailAddress: "VS@gmail.com", password: "password", specialistIn: ["Nephrologists"], image: UIImage(named: "Doctor3")!))
        
        database.append(Doctor(uniqueID : "4", firstName: "Sam", lastName: "Smith", emailAddress: "SS@gmail.com", password: "password", specialistIn: ["Dentist", "General Care"], image: UIImage(named: "Doctor4")!))
        
        database.append(Doctor(uniqueID : "5", firstName: "Robert", lastName: "Trap", emailAddress: "RT@gmail.com", password: "password", specialistIn: ["Neurologists", "Cardiologist"], image: UIImage(named: "Doctor5")!))
        
        database.append(Doctor(uniqueID : "6", firstName: "David", lastName: "Robertson", emailAddress: "DR@gmail.com", password: "password", specialistIn: ["Gastroenterology"], image: UIImage(named: "Doctor6")!))
        
        database.append(Doctor(uniqueID : "7", firstName: "Sarah", lastName: "Richardson", emailAddress: "SR@gmail.com", password: "password", specialistIn: ["Dermatologists"], image: UIImage(named: "Doctor7")!))
        
        database.append(Doctor(uniqueID : "8", firstName: "Max", lastName: "McDonald", emailAddress: "DR@gmail.com", password: "password", specialistIn: ["Ophthalmologists"], image: UIImage(named: "Doctor8")!))
        
        database.append(Doctor(uniqueID : "9", firstName: "Alexander", lastName: "Kraplin", emailAddress: "DR@gmail.com", password: "password", specialistIn: ["Obstetricians"], image: UIImage(named: "Doctor9")!))
        
        //Add doctors to database
    }
    
    func querryBySpecilist(type: String) -> [Doctor]{
        var docsWithSpecilist: [Doctor] = []
        for(var i = 0; i < self.database.count; i++){
            if(self.database[i].specialistIn.contains(type)){
              docsWithSpecilist.append(self.database[i])
            }
        }
        return docsWithSpecilist
    }
    
    func findDocWithID(theDocID: String) -> Doctor{
        for(var i = 0; i < self.database.count; i++){
            if(self.database[i].uniqueID == theDocID){
                return database[i]
            }
        }
        return database[0]
    }

    
    
}