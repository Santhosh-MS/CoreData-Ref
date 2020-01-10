//
//  Location+CoreDataProperties.swift
//  CoreDataStudent
//
//  Created by Ducont on 22/12/19.
//  Copyright © 2019 Ducont. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var home: NSSet?

}

// MARK: Generated accessors for home
extension Location {

    @objc(addHomeObject:)
    @NSManaged public func addToHome(_ value: Home)

    @objc(removeHomeObject:)
    @NSManaged public func removeFromHome(_ value: Home)

    @objc(addHome:)
    @NSManaged public func addToHome(_ values: NSSet)

    @objc(removeHome:)
    @NSManaged public func removeFromHome(_ values: NSSet)

}
