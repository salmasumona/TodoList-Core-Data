//
//  Category+CoreDataProperties.swift
//  LearningToDoList
//
//  Created by Apple on 22/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var title: String?
    @NSManaged public var allTasks: NSOrderedSet?

}

// MARK: Generated accessors for allTasks
extension Category {

    @objc(insertObject:inAllTasksAtIndex:)
    @NSManaged public func insertIntoAllTasks(_ value: Task, at idx: Int)

    @objc(removeObjectFromAllTasksAtIndex:)
    @NSManaged public func removeFromAllTasks(at idx: Int)

    @objc(insertAllTasks:atIndexes:)
    @NSManaged public func insertIntoAllTasks(_ values: [Task], at indexes: NSIndexSet)

    @objc(removeAllTasksAtIndexes:)
    @NSManaged public func removeFromAllTasks(at indexes: NSIndexSet)

    @objc(replaceObjectInAllTasksAtIndex:withObject:)
    @NSManaged public func replaceAllTasks(at idx: Int, with value: Task)

    @objc(replaceAllTasksAtIndexes:withAllTasks:)
    @NSManaged public func replaceAllTasks(at indexes: NSIndexSet, with values: [Task])

    @objc(addAllTasksObject:)
    @NSManaged public func addToAllTasks(_ value: Task)

    @objc(removeAllTasksObject:)
    @NSManaged public func removeFromAllTasks(_ value: Task)

    @objc(addAllTasks:)
    @NSManaged public func addToAllTasks(_ values: NSOrderedSet)

    @objc(removeAllTasks:)
    @NSManaged public func removeFromAllTasks(_ values: NSOrderedSet)

}
