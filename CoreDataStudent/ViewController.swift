//
//  ViewController.swift
//  CoreDataStudent
//
//  Created by Ducont on 20/12/19.
//  Copyright © 2019 Ducont. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }


    @IBAction func createDB(_ sender: Any) {
        guard let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: CoreDataManager.shared.manageObjectContext) else{
            return
        }
        
        let student = NSManagedObject(entity: studentEntity, insertInto: CoreDataManager.shared.manageObjectContext)
        
        student.setValue("Santhosh", forKeyPath: "firstName")
        student.setValue("Mohan", forKeyPath: "lastName")
        student.setValue("22-08-1995", forKeyPath: "birthDate")
        student.setValue(1001, forKeyPath: "regNO")
        
        do{
            try CoreDataManager.shared.manageObjectContext.save()
            print("core data sucessfully Saved ")
        }catch let err as NSError {
                print("cound not save .\(err),\(err.userInfo)")
        }
        
    }
    @IBAction func fetchDB(_ sender: Any) {
        let getfetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do{
            let result = try CoreDataManager.shared.manageObjectContext.fetch(getfetchData)
            for data in result as! [Student]{
                print(data)
                //print(data.value(forKey: "firstName") as! String)
                print("\(data.firstName!) Love \(data.lastName!)")
            }
        }catch let err as NSError{
            print("err : \(err.localizedFailureReason ?? "Faild Upadte")")
        }
        
        
    }
    
    @IBAction func updateDB(_ sender: Any) {
        
        let  updateDB = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        updateDB.predicate = NSPredicate(format: "firstName = %@","Santhosh")     // it used for filter the items for coreData array
        
        do{
            let updatedata = try CoreDataManager.shared.manageObjectContext.fetch(updateDB)
            for stud in updatedata as! [Student]{
                stud.firstName = "Kumar"
                stud.lastName = "Santhosh"
            }
            do{
                try CoreDataManager.shared.manageObjectContext.save()
            }catch let err as NSError{
                print("error : \(err.localizedDescription)")
            }
        }catch let err as NSError{
            print("error : \(err.localizedDescription)")
        }
    }
    
    @IBAction func deleteDB(_ sender: Any) {
        
        let  updateDB = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
               updateDB.predicate = NSPredicate(format: "firstName = %@","Kumar")
        
        do{
            let dataDelete = try CoreDataManager.shared.manageObjectContext.fetch(updateDB)
               // let deleteObject = dataDelete[0] as! Student
            
            for  deleteObject in dataDelete as! [Student] {
                CoreDataManager.shared.manageObjectContext.delete(deleteObject)

            }
            print("sucessfully deleted")
        }catch let err as NSError {
            print("error : \(err.localizedDescription)")

        }
        
    }
    
    
}



