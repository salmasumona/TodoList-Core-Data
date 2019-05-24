//
//  ViewController.swift
//  LearningToDoList
//
//  Created by Apple on 16/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TaskController: UIViewController {
    
    let taskTable = CommonUIContainer.shared.commonTableView()
    let tableIdentifier = "task"
    var category: Category?
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Task"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 37, weight: UIFont.Weight.semibold)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
        // Do any additional setup after loading the view, typically from a nib.
        taskTable.register(taskTableCell.self, forCellReuseIdentifier: tableIdentifier)
        taskTable.delegate = self
        taskTable.dataSource = self
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.taskTable.reloadData()
    }
    func setupView(){
        view.addSubview(taskTable)
        NSLayoutConstraint.activate([
            taskTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            taskTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            taskTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            taskTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2)
            ])
    }
    @objc func addBtnTapped(_ sender: UIButton){
         let newTC = NewTask()
         newTC.category = category
         present(newTC, animated: true, completion: { })
    }
    func deleteTask(at indexPath: IndexPath){
        guard let task = category?.tasks?[indexPath.row],
            let managedContext = task.managedObjectContext else {
                return
        }
        managedContext.delete(task)
        do{
            try managedContext.save()
            taskTable.deleteRows(at: [indexPath], with: .automatic)
        }catch{
            print("Unable to delete.")
            taskTable.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

