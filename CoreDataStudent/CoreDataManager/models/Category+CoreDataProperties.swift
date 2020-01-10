//
//  Category+CoreDataProperties.swift
//  CoreDataStudent
//
//  Created by Ducont on 22/12/19.
//  Copyright © 2019 Ducont. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var homeType: String?
    @NSManaged public var home: Home?

}
