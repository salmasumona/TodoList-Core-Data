//
//  LearnTableViewController.swift
//  LearningToDoList
//
//  Created by Apple on 16/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension LearnCategoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) //as! LearnCategoryCell
        if categories.isEmpty == false {
            let category = categories[indexPath.row]
            cell.textLabel?.text = category.title
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCategory(at: indexPath)
        }
    }
    
}
extension LearnCategoryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedRow = self.categoryTable.indexPathForSelectedRow?.row else {
           return
        }
        let tC = TaskController()
        tC.category = categories[selectedRow]
        self.navigationController?.pushViewController(tC, animated: true)
    }
}
