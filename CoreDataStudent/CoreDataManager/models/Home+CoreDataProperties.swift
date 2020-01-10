//
//  Home+CoreDataProperties.swift
//  CoreDataStudent
//
//  Created by Ducont on 22/12/19.
//  Copyright © 2019 Ducont. All rights reserved.
//
//

import Foundation
import CoreData


extension Home {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Home> {
        return NSFetchRequest<Home>(entityName: "Home")
    }

    @NSManaged public var price: Double
    @NSManaged public var sqft: Int16
    @NSManaged public var bath: Int16
    @NSManaged public var bed: Int16
    @NSManaged public var country: String?
    @NSManaged public var image: Data?
    @NSManaged public var category: Category?
    @NSManaged public var location: Location?
    @NSManaged public var status: Status?

}
