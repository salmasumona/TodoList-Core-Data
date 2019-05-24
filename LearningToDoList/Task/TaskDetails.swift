

import UIKit
import CoreData

class TaskDetails: UIViewController {
    let moduleTitle = CommonUIContainer.shared.commonLabelUI(text: "", color: UIColor.white, textColor: UIColor.black,font:CGFloat(26))
    let startDate = CommonUIContainer.shared.commonLabelUI(text: "", color: UIColor.white, textColor: UIColor.black,font:CGFloat(26))
    let endDate = CommonUIContainer.shared.commonLabelUI(text: "", color: UIColor.white, textColor: UIColor.black,font:CGFloat(26))
    let taskStatus = CommonUIContainer.shared.commonLabelUI(text: "", color: UIColor.white, textColor: UIColor.black,font:CGFloat(26))
    let taskStatusOnOff = UISwitch(frame:CGRect(x: 200, y: 0, width: 400, height: 80))
    var task: Task?
    var dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Task Details"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 37, weight: UIFont.Weight.semibold)]
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "(moduleName = %@)", (task?.moduleName)!)
        fetchRequest.predicate = predicate
        do {
            let result =
                try managedContext.fetch(fetchRequest)
            task = result[0] as NSManagedObject as? Task
        }catch{
            print("error")
        }
        
        moduleTitle.text = task?.moduleName
        if let sDate = task?.sDate {
            startDate.text = dateFormatter.string(from: sDate)
        }
        if let tDate = task?.tDate {
            endDate.text = dateFormatter.string(from: tDate)
        }
        
        if task?.status == Bool(truncating: 1) {
            taskStatus.text = "Completed"
            taskStatusOnOff.isOn = true
        }else{
            taskStatus.text = "Not completed"
            taskStatusOnOff.isOn = false
        }
    }
    func setupViews(){
        taskStatusOnOff.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        taskStatusOnOff.setOn(true, animated: false)
        //taskStatusOnOff.thumbTintColor = .green
        let stackInputs = CommonUIContainer.shared.commoninputStackView(arr: [moduleTitle,startDate,endDate,taskStatus,taskStatusOnOff])
       
        view.addSubview(stackInputs)
        stackInputs.addBackground(color: .lightGray)
        NSLayoutConstraint.activate([
            stackInputs.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackInputs.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackInputs.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.6),
            stackInputs.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.2)
        ])
    }
    @objc func switchStateDidChange(_ sender:UISwitch){
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            updateTask(status: true)
        }
        else{
            print("UISwitch state is now Off")
            updateTask(status: false)
        }
    }
    func updateTask(status: Bool){
  
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "(moduleName = %@)", (task?.moduleName)!)
        fetchRequest.predicate = predicate
        do {
            let result = try managedContext.fetch(fetchRequest)
            task = result[0] as NSManagedObject as? Task
            task?.setValue(status, forKey: "status")
            do {
                try managedContext.save()
                if status == true {
                    taskStatusOnOff.isOn = true
                }else{
                   taskStatusOnOff.isOn = false
                }
            }catch  let error as NSError {
                print("\(error)")
            }
        }catch let error as NSError {
            print("\(error)")
        }
    }
}
