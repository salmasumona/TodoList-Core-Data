//
//  Task+CoreDataClass.swift
//  LearningToDoList
//
//  Created by Apple on 22/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    var sDate: Date? {
        get{
            return startDate as Date?
        }
        set{
            startDate = newValue as NSDate?
        }
    }
    var tDate: Date? {
        get{
            return targetDate as Date?
        }
        set{
            targetDate = newValue as NSDate?
        }
    }
    convenience init?(moduleName:String, sDate: Date, tDate:Date, status: Bool) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        self.init(entity: Task.entity(), insertInto: context)
        self.moduleName = moduleName
        self.sDate = sDate
        self.tDate = tDate
        self.status = status
    }
}
