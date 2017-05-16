//
//  MemoryEntity+CoreDataProperties.swift
//  DemoMemoryGame
//
//  Created by Manish on 04/02/17.
//  Copyright © 2017 Manish. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MemoryEntity {

    @NSManaged var rank: NSNumber?
    @NSManaged var username: String?
    @NSManaged var userscore: NSNumber?

}
