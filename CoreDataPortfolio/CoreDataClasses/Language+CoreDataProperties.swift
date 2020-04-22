//
//  Language+CoreDataProperties.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/22/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//
//

import Foundation
import CoreData


extension Language {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Language> {
        return NSFetchRequest<Language>(entityName: "Language")
    }

    @NSManaged public var name: String
    @NSManaged public var year: String
    @NSManaged public var pic: Data

}
