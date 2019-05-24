//
//  Category+CoreDataClass.swift
//  LearningToDoList
//
//  Created by Apple on 22/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Category)
public class Category: NSManagedObject {
    var tasks: [Task]? {
        return self.allTasks?.array as? [Task]
    }
    convenience init?(title:String) {
        let appDaelgate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDaelgate?.persistentContainer.viewContext else {
            return nil
        }
        self.init(entity: Category.entity(), insertInto: context)
        self.title = title
    }
}
