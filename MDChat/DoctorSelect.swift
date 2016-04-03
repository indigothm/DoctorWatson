//
//  DoctorSelect.swift
//  MDChat
//
//  Created by Ilia Tikhomirov on 03/04/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import WatsonDeveloperCloud

class DoctorSelect {
    
    var docDatabase = DoctorDatabase()
    var theDocID = "fakeDoc"
    var currentDoc: Doctor! 
    
    var theKeywords: [Keyword] = []
    
    static let sharedInstance = DoctorSelect()
    
    func findADoctor(prevDocID:String) -> Doctor{
        theDocID = prevDocID
        print("THE PREV ID IS: \(prevDocID)")
        print("THE KEYWORDS ARE: \(theKeywords)")
        //NOTE:  It is known that the keywords are sorted from highest relevance to lowest
        for(var i = 0; i < theKeywords.count; i++){
            print(i)
            print("The word is!!!: \(theKeywords[i])")
            
            if(theKeywords[i].text?.lowercaseString == "sports" ||
                theKeywords[i].text?.lowercaseString == "workingout" ||
                theKeywords[i].text?.lowercaseString == "gym" ||
                theKeywords[i].text?.lowercaseString == "weight lifting" ||
                theKeywords[i].text?.lowercaseString == "soccer" ||
                theKeywords[i].text?.lowercaseString == "hockey" ||
                theKeywords[i].text?.lowercaseString == "sport"
                ){
                theDocID = findDoctorOfType("Sports",prevDocID: prevDocID)
            }
            
            if(theKeywords[i].text?.lowercaseString == "heart" ||
                theKeywords[i].text?.lowercaseString == "heart pain" ||
                theKeywords[i].text?.lowercaseString == "blood vessels" ){
                print("does it enter this?!")
                theDocID = findDoctorOfType("Cardiologist",prevDocID: prevDocID)
            }
            
            if(theKeywords[i].text?.lowercaseString == "teeth" ||
                theKeywords[i].text?.lowercaseString == "tooth" ||
                theKeywords[i].text?.lowercaseString == "tooth pain" ||
                theKeywords[i].text?.lowercaseString == "tooth discomfort" ||
                theKeywords[i].text?.lowercaseString == "mouth pain" ){
                theDocID = findDoctorOfType("Dentist",prevDocID: prevDocID)
            }
            
            if(theKeywords[i].text?.lowercaseString == "skin infection" ||
                theKeywords[i].text?.lowercaseString == "skin" ||
                theKeywords[i].text?.lowercaseString == "skin rash" ||
                theKeywords[i].text?.lowercaseString == "rash" ||
                theKeywords[i].text?.lowercaseString == "skin discoloration" ){
                theDocID = findDoctorOfType("Dermatologists",prevDocID: prevDocID)
            }
            if(theKeywords[i].text?.lowercaseString == "stomach pain" ||
                theKeywords[i].text?.lowercaseString == "stomach" ||
                theKeywords[i].text?.lowercaseString == "digestive issues" ||
                theKeywords[i].text?.lowercaseString == "trouble eating" ){
                theDocID = findDoctorOfType("Gastroenterology",prevDocID: prevDocID)
            }
            
            if(theKeywords[i].text?.lowercaseString == "kidney" ||
                theKeywords[i].text?.lowercaseString == "kidney pain" ||
                theKeywords[i].text?.lowercaseString == "kidney stones" ||
                theKeywords[i].text?.lowercaseString == "kidney stone" ){
                theDocID = findDoctorOfType("Nephrologists",prevDocID: prevDocID)
            }
            
            if(theKeywords[i].text?.lowercaseString == "nervous system" ||
                theKeywords[i].text?.lowercaseString == "brain infection" ||
                theKeywords[i].text?.lowercaseString == "spinal cord" ||
                theKeywords[i].text?.lowercaseString == "spinal cord infection" ){
                theDocID = findDoctorOfType("Neurologists",prevDocID: prevDocID)
            }
            
            
            if(theKeywords[i].text?.lowercaseString == "childbirth" ||
                theKeywords[i].text?.lowercaseString == "pregnancy pain" ||
                theKeywords[i].text?.lowercaseString == "pregnancy" ||
                theKeywords[i].text?.lowercaseString == "pregnant" ){
                theDocID = findDoctorOfType("Obstetricians",prevDocID: prevDocID)
            }
            
            if(theKeywords[i].text?.lowercaseString == "eye" ||
                theKeywords[i].text?.lowercaseString == "eye pain" ||
                theKeywords[i].text?.lowercaseString == "blind" ||
                theKeywords[i].text?.lowercaseString == "blindness" ){
                theDocID = findDoctorOfType("Ophthalmologists",prevDocID: prevDocID)
            }
            
            if(theKeywords[i].text?.lowercaseString == "mental" ||
                theKeywords[i].text?.lowercaseString == "mentally ill" ||
                theKeywords[i].text?.lowercaseString == "stressed"){
                theDocID = findDoctorOfType("Psychiatrist",prevDocID: prevDocID)
            }
            print("Last line before is \(theDocID)")
            if(theDocID != "fakeDoc" && theDocID != prevDocID){
                return docDatabase.findDocWithID(theDocID)
            }
            
        }
        
        if(theDocID == "fakeDoc"){
            theDocID = findRandomDoc()
        }
        if(theDocID == prevDocID){
            theDocID = findRandomDoc()
        }
        return docDatabase.findDocWithID(theDocID)
        print("THE DOC ID IS \(theDocID)")
    }
    
    func findRandomDoc() -> String{
        let randomValue = Int(arc4random_uniform(UInt32(docDatabase.database.count)))
        return docDatabase.database[randomValue].uniqueID
    }
    
    func findDoctorOfTypeOrig(type: String) -> String{
        var querryData = docDatabase.querryBySpecilist(type)
        print("The size of the querry is: \(querryData.count)")
        if(querryData.count == 0){
            return "fakeDoc"
        }
        let randomValue = Int(arc4random_uniform(UInt32(docDatabase.database.count)))
        return (querryData[randomValue].uniqueID)
    }
    
    func findDoctorOfType(type:String, prevDocID: String)-> String{
        var querryData = docDatabase.querryBySpecilist(type)
        print("The size of the querry is: \(querryData.count)")
        if(querryData.count == 0){
            return "fakeDoc"
        }
        let randomValue = Int(arc4random_uniform(UInt32(querryData.count)))
        print("The Doctor ID is: \(prevDocID)")
        if(querryData[randomValue].uniqueID == prevDocID){
            return findRandomDoc()
        }
        return (querryData[randomValue].uniqueID)
    }
    
}