//
//  AddNewTask.swift
//  LearningToDoList
//
//  Created by Apple on 16/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
class NewTask: UIViewController {
    //let crossBtn = CommonUIContainer.shared.commonInputButton(withColor: UIColor.white, title: "", alphaVal: CGFloat(1.0), titleColor: UIColor.red)
   // let headerTitle = CommonUIContainer.shared.commonLabelUI(text: "Add New Task", color: UIColor.white, textColor: UIColor.black,font:CGFloat(26))
    let moduleNameInput = CommonUIContainer.shared.commonInputFieldForForm(placeHolder: "Module Name")
    let dateTextFieldStart = CommonUIContainer.shared.commonInputFieldForForm(placeHolder: "Start Date")
    let dateTextFieldEnd = CommonUIContainer.shared.commonInputFieldForForm(placeHolder: "Target Date")
    let addBtn = CommonUIContainer.shared.commonInputButton(withColor: UIColor(red:90/255, green:185/255, blue:91/255, alpha:1.0), title: "Add Task", alphaVal: CGFloat(1.0), titleColor: UIColor.white)
    let datePicker = UIDatePicker()
    var category: Category?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Add New Task"
        moduleNameInput.textAlignment = .center
        dateTextFieldStart.textAlignment = .center
        dateTextFieldEnd.textAlignment = .center
        moduleNameInput.becomeFirstResponder()
        
        setupViews()
    }
    func setupViews(){
//        crossBtn.setImage(UIImage(named: "cancel_64"), for: .normal)
//        crossBtn.addTarget(self, action: #selector(pageCloseTapped), for: .touchUpInside)
//        crossBtn.contentMode = .right
//        crossBtn.imageView?.contentMode = .scaleAspectFit
//        crossBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: -5)
//        view.addSubview(crossBtn)
//        NSLayoutConstraint.activate([
//            crossBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            crossBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
//            crossBtn.heightAnchor.constraint(equalToConstant: 40)
//        ])
//
//        headerTitle.textAlignment = .center
//        view.addSubview(headerTitle)
//        NSLayoutConstraint.activate([
//            headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            headerTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.8),
//            headerTitle.heightAnchor.constraint(equalToConstant: 40)
//        ])
        let stackInputs = CommonUIContainer.shared.commoninputStackView(arr: [moduleNameInput,dateTextFieldStart,dateTextFieldEnd,addBtn])
        dateTextFieldStart.addTarget(self, action: #selector(startdateBtnClicked(_:)),for: .editingDidBegin)
        dateTextFieldEnd.addTarget(self, action: #selector(enddateBtnClicked(_:)),for: .editingDidBegin)
        addBtn.addTarget(self, action: #selector(addBtnClicked(_:)),for: .touchUpInside)
        view.addSubview(stackInputs)
        stackInputs.addBackground(color: .lightGray)
        NSLayoutConstraint.activate([
            //stackInputs.topAnchor.constraint(equalTo: headerTitle.bottomAnchor),
            stackInputs.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackInputs.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackInputs.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.6),
            stackInputs.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:0.2)
        ])
        
    }
    
    @objc func pageCloseTapped(){
        print("closed")
        pageClose()
    }
    func pageClose(){
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    @objc func startdateBtnClicked(_ sender:UITextField) {
        sender.inputView = self.datePicker
        sender.inputAccessoryView = self.createToolbar(type:"startDate")
    }
    @objc func enddateBtnClicked(_ sender:UITextField) {
        sender.inputView = self.datePicker
        sender.inputAccessoryView = self.createToolbar(type:"endDate")
    }
    func createToolbar(type:String) -> UIToolbar {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(doneStartdatePicker(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(cancelDatePicker(_:)))
        if type == "startDate" {
            toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        }else{
            let doneButton1 = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(doneEnddatePicker(_:)))
            toolbar.setItems([doneButton1,spaceButton,cancelButton], animated: false)
        }
        
        toolbar.barStyle = .default
        toolbar.tintColor = UIColor.black
        toolbar.isTranslucent = false
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        return toolbar
    }
    @objc func doneStartdatePicker(_ sender: AnyObject) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextFieldStart.text = formatter.string(from: datePicker.date)
        let currentDate = CommonUIContainer.shared.getCurrentDate()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        if currentDate <= formatter1.string(from: datePicker.date) {
            self.view.endEditing(true)
            print("newdate is earlier than current")
        }else{
            self.createAlert(titleText: "", messageText: "You can not choose earlier date.")
        }
    }
    @objc func cancelDatePicker(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    @objc func doneEnddatePicker(_ sender: AnyObject) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextFieldEnd.text = formatter.string(from: datePicker.date)
        let currentDate = CommonUIContainer.shared.getCurrentDate()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        if currentDate <= formatter1.string(from: datePicker.date) {
            self.view.endEditing(true)
            print("newdate is earlier than current")
        }else{
            self.createAlert(titleText: "", messageText: "You can not choose earlier date.")
        }
    }
    @objc func addBtnClicked(_ sender: UIButton){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let moduleName = moduleNameInput.text, !moduleName.isEmpty else {return}
       
        guard let dateTextFieldStart = dateTextFieldStart.text, !dateTextFieldStart.isEmpty else {return}
         guard let dateTextFieldEnd = dateTextFieldEnd.text, !dateTextFieldEnd.isEmpty else {return}
        let sDate = dateFormatter.date(from: dateTextFieldStart)
        let tDate = dateFormatter.date(from: dateTextFieldEnd)
        let status = false
        if let createTask = Task(moduleName: moduleName, sDate: sDate ?? Date(), tDate: tDate ?? Date(), status: status){
            category?.addToAllTasks(createTask)
            do{
               try createTask.managedObjectContext?.save()
                pageClose()
            }catch{
                print("Unable to save tasks")
            }
        }
    }
}
