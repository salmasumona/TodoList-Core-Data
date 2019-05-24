//
//  LearnTableViewController.swift
//  LearningToDoList
//
//  Created by Apple on 16/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension TaskController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) //as! taskTableCell
        cell.accessoryType = .detailButton
        if let task = category?.tasks?[indexPath.row] {
            cell.textLabel?.text = task.moduleName
            if task.status == true {
                cell.detailTextLabel?.text = "Completed"
            }else {
                cell.detailTextLabel?.text = "Not completed"
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(at: indexPath)
        }
    }
    
}
extension TaskController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let tC = TaskDetails()
        tC.task = category?.tasks?[indexPath.row]
        self.navigationController?.pushViewController(tC, animated: true)
    }
    
}
