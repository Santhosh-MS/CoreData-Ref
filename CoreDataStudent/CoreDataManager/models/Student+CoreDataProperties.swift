//
//  Student+CoreDataProperties.swift
//  CoreDataStudent
//
//  Created by Ducont on 21/12/19.
//  Copyright © 2019 Ducont. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var birthDate: String?
    @NSManaged public var regNO: Int32

}
