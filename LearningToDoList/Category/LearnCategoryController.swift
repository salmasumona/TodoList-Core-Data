//
//  ViewController.swift
//  LearningToDoList
//
//  Created by Apple on 16/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CoreData

class LearnCategoryController: UIViewController {
    
    let categoryTable = CommonUIContainer.shared.commonTableView()
    let tableIdentifier = "category"
    var categories:[Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Learn Category"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 37, weight: UIFont.Weight.semibold)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
        // Do any additional setup after loading the view, typically from a nib.
        categoryTable.register(LearnCategoryCell.self, forCellReuseIdentifier: tableIdentifier)
        categoryTable.delegate = self
        categoryTable.dataSource = self
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchStoredData()
    }
   func fetchStoredData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try managedContext.fetch(fetchRequest)
            categoryTable.reloadData()
        }catch{
            print("Unable to fetch.")
        }
    }
    func setupView(){
        view.addSubview(categoryTable)
        NSLayoutConstraint.activate([
            categoryTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            categoryTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            categoryTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            categoryTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2)
        ])
    }
    @objc func addBtnTapped(_ sender: UIButton){
        print("add btn tapped")
        let alert = UIAlertController(title: "Category Title", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.addCategoryTitle(textField:alert.textFields![0])
        })
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
    func addCategoryTitle(textField:UITextField){
        print("Text field: \(textField.text ?? "")")
        
        guard let catText = textField.text, !catText.isEmpty else {
            return
        }
        let category = Category(title: catText)
        do{
            try category?.managedObjectContext?.save()
            fetchStoredData()
        }catch{
            print("Unable to save category.")
        }
    }
    func deleteCategory(at indexPath: IndexPath){
         let category = categories[indexPath.row]
        guard let managedContext = category.managedObjectContext else { return }
        
        managedContext.delete(category)
        do {
            try managedContext.save()
            categories.remove(at: indexPath.row)
            categoryTable.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Unable to delete.")
            categoryTable.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

