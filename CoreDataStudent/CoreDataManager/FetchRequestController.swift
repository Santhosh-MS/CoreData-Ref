//
//  FetchRequestController.swift
//  CoreDataStudent
//
//  Created by Ducont on 04/01/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import UIKit
import CoreData

class FetchRequestController: UIViewController {
    @IBOutlet weak var frcTableview: UITableView!
    
   
    var fetchController : NSFetchedResultsController<Book>!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        frcTableview.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.AddTextData()
    }
    func loadData(){
        let BookFetchRequest = NSFetchRequest<Book>(entityName: "Book")
        //let BookFetchRequest : NSFetchRequest<Book> = Book.fetchRequest()
        let sortDescription = NSSortDescriptor(key: #keyPath(Book.author), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
            BookFetchRequest.sortDescriptors = [sortDescription]
            fetchController = NSFetchedResultsController(fetchRequest: BookFetchRequest, managedObjectContext: CoreDataManager.shared.manageObjectContext, sectionNameKeyPath: "author", cacheName: nil)
            do{
                try fetchController.performFetch()
            
            }catch {
                print("Error loading error :\(error)")
            }
            self.frcTableview.reloadData()
        }
    
    func AddTextData(){
        let  authoreText = UITextField()
        let  titleText = UITextField()
        let alert = UIAlertController(title: "Create new book", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Book", style: .default) { (action) in
        //            guard let BookEntity = NSEntityDescription.entity(forEntityName: "Book", in: CoreDataManager.shared.manageObjectContext) else{
        //                return
        //            }
        //            let newBook = NSManagedObject(entity:
        //                BookEntity, insertInto: CoreDataManager.shared.manageObjectContext) as! Book
        let newBook = Book(context: CoreDataManager.shared.manageObjectContext)
        newBook.author =  alert.textFields?[0].text
        newBook.title =  alert.textFields?[1].text
        do{
            try CoreDataManager.shared.manageObjectContext.save()
            //self.frcTableview.reloadData()
            self.loadData()
            }catch let err as NSError{
                print("err--->:\(err.localizedDescription)")
            }
            }
            alert.addAction(action)
            alert.addTextField { (auth) in
            auth.placeholder = "New Author Name Here"
            authoreText.text = auth.text
            }
            alert.addTextField { (title) in
            title.placeholder = "Book title"
            titleText.text = title.text
        }
            present(alert,animated : true,completion : nil)
    }
}

extension FetchRequestController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
          if let frc = fetchController{
              return frc.sections!.count
          }
          return 0
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchController.sections!.count
        
        guard let sections = self.fetchController.sections else{
            fatalError("No Such in fetchRequest Controller ?")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sessionInfo = fetchController?.sections?[section] else {
            return "Add items"
        }
        let title = sessionInfo.name
        return title
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        let entity = fetchController.object(at: indexPath)
        cell.bookTiTle.text = entity.title ?? "ADD Book"
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchController.sectionIndexTitles
    }
//func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//    guard let result = fetchController.section(forSectionIndexTitle: title,at : index ) else {
//        fatalError("Unable to locate Section for \(title) at :\(index)")
//    }
//
//    return result
//
//    }
}


