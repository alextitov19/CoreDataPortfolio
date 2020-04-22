//
//  Account+CoreDataProperties.swift
//  CoreDataPortfolio
//
//  Created by Test on 4/22/20.
//  Copyright © 2020 AlexTitovProductions. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var password: String
    @NSManaged public var username: String

}
