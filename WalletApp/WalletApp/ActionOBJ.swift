//
//  Beer.swift
//  BeerTracker
//
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import Foundation
import CoreData

// This directive makes the class accessible to Objective-C code from the MagicalRecord library.
@objc(ActionOBJ)

class ActionOBJ: NSManagedObject {

  // Attributes
    @NSManaged var value: String
    @NSManaged var currency: String

}
