//
//  Books+CoreDataProperties.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/22/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Book")
    }

    @NSManaged public var title: String
    @NSManaged public var author: String
    @NSManaged public var date: String

}
