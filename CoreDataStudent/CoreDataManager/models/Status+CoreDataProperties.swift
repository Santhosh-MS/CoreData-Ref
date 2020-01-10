//
//  Status+CoreDataProperties.swift
//  CoreDataStudent
//
//  Created by Ducont on 22/12/19.
//  Copyright © 2019 Ducont. All rights reserved.
//
//

import Foundation
import CoreData


extension Status {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Status> {
        return NSFetchRequest<Status>(entityName: "Status")
    }

    @NSManaged public var isForSale: Bool
    @NSManaged public var home: Home?

}
