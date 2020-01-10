//
//  CoreDataTableView.swift
//  CoreDataStudent
//
//  Created by Ducont on 22/12/19.
//  Copyright © 2019 Ducont. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableView: UIViewController {

    var dataList : [List] = []
    var location : Location!
    
    @IBOutlet weak var dataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CoreDataJson()
        self.dataFetch()
        // Do any additional setup after loading the view.
    }
    
    func dataFetch()->Void{
    let ListFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            self.dataList = try CoreDataManager.shared.manageObjectContext.fetch(ListFetch) as! [List]
            dataTableView.reloadData()
            }catch let err as NSError{
             print("err--> msg : \(err.localizedDescription)")
            }
    }
    
    @IBAction func addDataTableList(_ sender: Any) {
        let alertController = UIAlertController(title: "Core Data", message: "Add List Data", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField) -> Void in
            
        }
        let addAction = UIAlertAction(title: "ADD", style:.default) { (action : UIAlertAction) in
            
            guard let data = alertController.textFields?.first?.text else{
                
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: "List", in: CoreDataManager.shared.manageObjectContext)!
            let List = NSManagedObject(entity: entity, insertInto: CoreDataManager.shared.manageObjectContext) as! List
             List.nameList = data
            do{
              try  CoreDataManager.shared.manageObjectContext.save()
                print("core data sucessfully Saved ")
                self.dataFetch()
                
            }catch let err as NSError{
                print("sample not  : \(err.localizedDescription)")
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.default) { (action : UIAlertAction) in

        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK:- table viewdelegate & DataSource


extension  CoreDataTableView : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.dataList.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
       let data = dataList[indexPath.row] as List
        Cell.textLabel?.text = data.nameList
        return Cell
    }
    
}

//MARK:- codeData with Json pasing

extension CoreDataTableView {
    func CoreDataJson() -> Void{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Home")
        do{
            let homeCount = try CoreDataManager.shared.manageObjectContext.count(for: request)
            print("homeCount : \(homeCount)")
            
            if homeCount == 0 {
                self.uploadJsonData()
            }
        }catch let err as NSError {
            print("error : \(err.localizedDescription)")
        }
        
    }
    
    func uploadJsonData() -> Void{
        let data : Data!
        let url = Bundle.main.url(forResource: "ContentData", withExtension: "json")!   //find the url for perticular file
        do{
           data  = try Data(contentsOf: url)
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
            
            let jsonArray = jsonData.value(forKey: "home") as! NSArray
            print(jsonArray)
            for json in jsonArray {
                let data = json as! NSDictionary
              let home = NSEntityDescription.insertNewObject(forEntityName: "Home", into: CoreDataManager.shared.manageObjectContext) as! Home
                home.country = data["city"] as? String
                home.price = data["price"]  as! Double
                home.bed = data["bed"] as! Int16
                home.bath = data["bath"] as! Int16
                home.sqft = data["sqft"] as! Int16
                
                let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: CoreDataManager.shared.manageObjectContext) as! Category
                
                let datacategory  =  data["category"] as! NSDictionary
                category.homeType = datacategory.value(forKey:"homeType")  as? String
                
                let Status = NSEntityDescription.insertNewObject(forEntityName: "Status", into: CoreDataManager.shared.manageObjectContext) as! Status
                let dataStatus = data["status"] as! NSDictionary
                Status.isForSale = dataStatus.value(forKey: "isForSale")  as! Bool
                
                let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: CoreDataManager.shared.manageObjectContext) as! Location
                location.city = data["city"] as? String
                let imageName = data["image"] as? String
                let image = UIImage(named : imageName!)
                let imageData = image?.jpegData(compressionQuality: 1.0)
                home.image = imageData
                home.category = category
                home.status = Status
                home.location = location
            }
           try CoreDataManager.shared.manageObjectContext.save()
        }catch let err as NSError{
            print("err -> : \(err.localizedDescription)")
        }
        
        self.fetchHomeData()
       
    }
    
    
    
    
    func fetchHomeData() -> Void{
        let HomeData = NSFetchRequest<NSFetchRequestResult>(entityName: "Home")
        
        do{
            let resultHomeData = try CoreDataManager.shared.manageObjectContext.fetch(HomeData) as! [Home]
            for home in resultHomeData {
                
                self.location = Location()
                self.location = home.location
                print("location : \(location.city ?? "not get")")
            }
            
        }catch  let err as NSError {
            print("err ---> : \(err)")
        }
    }
}




