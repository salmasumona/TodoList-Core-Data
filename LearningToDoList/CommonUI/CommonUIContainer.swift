//
//  CommonUI.swift
//  CheckList
//
//  Created by Sumona Salma on 4/13/19.
//  Copyright © 2019 Sumona Salma. All rights reserved.
//

import UIKit
import Foundation

class CommonUIContainer: UIViewController {
    static let shared = CommonUIContainer()
    func commonUITextField (placeHolder:String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.textAlignment = .left
        textField.textColor = UIColor.darkGray
        textField.backgroundColor = UIColor.white
        textField.tintColor = UIColor.black
        textField.adjustsFontSizeToFitWidth = true
        //textField.becomeFirstResponder()
        textField.minimumFontSize = 12
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    func commonTableView() -> UITableView {
        let view = UITableView(frame: CGRect.zero, style: .plain)
        view.rowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    func commonLabelUI(text: String, color: UIColor,textColor:UIColor,font:CGFloat) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.text = text
        label.textColor = textColor
        label.backgroundColor = color
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.font = label.font.withSize(font)
        label.minimumScaleFactor=0.3
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    func commonInputButton(withColor color:UIColor, title:String, alphaVal:CGFloat,titleColor:UIColor) -> UIButton{
        let button = UIButton()
        button.backgroundColor = color
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = color.withAlphaComponent(alphaVal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: button.titleLabel!.font.pointSize)
        //button.titleLabel?.minimumScaleFactor=0.1
        button.titleLabel!.numberOfLines = 2
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        button.titleLabel!.adjustsFontSizeToFitWidth = true
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    func commonInputFieldForForm (placeHolder:String) -> UITextField {
        let textView = UITextField()
        textView.placeholder = placeHolder
        textView.textAlignment = .left
        textView.textColor = UIColor.darkGray
        textView.backgroundColor = UIColor.white
        textView.tintColor = UIColor.black
        //textView.font = UIFont.systemFont(ofSize: 22)
        textView.adjustsFontSizeToFitWidth = true
        textView.becomeFirstResponder()
        textView.inputView = UIView()
        textView.minimumFontSize = 12
        textView.font = UIFont.systemFont(ofSize: 20)
        //textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: textView.frame.size.height))
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }
    func commoninputStackView(arr: Array<Any>)-> UIStackView{
        //Stack View
        let stackView   = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.backgroundColor = UIColor.blue
        
        for row in arr {
            stackView.addArrangedSubview(row as! UIView)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    func getCurrentDate() -> String {
        var dateString = ""
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"//"yyyy-MM-dd HH:mm:ss"
        let date = Date()
        dateString = dateFormatter.string(from: date)
        return dateString
    }
}
extension UIViewController {
    
    func createAlert(titleText : String, messageText : String){
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
