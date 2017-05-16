//
//  MemoryEntity.swift
//  DemoMemoryGame
//
//  Created by Manish on 04/02/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import Foundation
import CoreData


class MemoryEntity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    //c prefix just to allowed conflit
    @NSManaged var cuserscore: NSInteger
    @NSManaged var cusername: String?
    @NSManaged var crank: Int
}
