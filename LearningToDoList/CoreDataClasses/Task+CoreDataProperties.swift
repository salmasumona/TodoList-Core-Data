//
//  Task+CoreDataProperties.swift
//  LearningToDoList
//
//  Created by Apple on 22/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var moduleName: String?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var targetDate: NSDate?
    @NSManaged public var status: Bool
    @NSManaged public var category: Category?

}
