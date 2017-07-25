//
//  TotalViewController.swift
//  StandAloneScreen
//
//  Created by NISUM on 7/18/17.
//  Copyright © 2017 Nisum Macbook. All rights reserved.
//

import UIKit

class TotalViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    let showKeyBoardNotiName = Notification.Name("ShowKeyboard")
    let totalTextFieldNotiName = Notification.Name("TotalEnterDigit")
    let calculateAmountNotiName = Notification.Name("CalculateAmount")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.clearBottomBorder()
        NotificationCenter.default.addObserver(self, selector: #selector(updateField(not:)), name: totalTextFieldNotiName, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Textfields delegate methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.setBottomBorder()
        NotificationCenter.default.post(name: showKeyBoardNotiName, object: self, userInfo: ["type": 0])

    }
    
    // Notification handler
    func updateField(not: Notification) {
        // NotificationInfo is the payload send by sender of notification
        if let notificationInfo = not.userInfo {
            // Safely unwrap the tag sent out by the notification sender
            if let digit = notificationInfo["digit"] as? Int {
                updateTextFieldValue(digit: digit)
            }
        }
    }
    
    
    // Updating text field value
    func updateTextFieldValue(digit: Int){
            let value : String = ("\(String(describing: textField!.text!))\(digit)")
            
            if digit == -1 {
                textField?.text = textField?.text?.substring(to: (textField?.text?.index(before: (textField?.text?.endIndex)!))!)
            }
            else if digit == -2 {
                textField?.text = String((textField?.text)! + ("00"))
            }
            else {
                textField.text = value.currency()
            }
        let total = Double(textField.text!.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: ""))
//        let doubleTotal = Double(total!)
        
        NotificationCenter.default.post(name: calculateAmountNotiName, object: self, userInfo: ["total":total!])

    }

}

extension String {
    
    func currency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let digits = NSDecimalNumber(string: sanitized())
        let place = NSDecimalNumber(value: powf(10, 2))
        return formatter.string(from: digits.dividing(by: place))
    }

    func sanitized() -> String {
        return String(self.characters.filter { "01234567890".characters.contains($0) })
    }
    
}
