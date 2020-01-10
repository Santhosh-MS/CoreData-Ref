//
//  Book+CoreDataProperties.swift
//  CoreDataStudent
//
//  Created by Ducont on 04/01/20.
//  Copyright © 2020 Ducont. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?

}
