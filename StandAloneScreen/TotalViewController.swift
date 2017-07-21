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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.setBottomBorder()
        NotificationCenter.default.post(name: showKeyBoardNotiName, object: self, userInfo: ["type": 0])

    }
    func updateField(not: Notification) {
        // NotificationInfo is the payload send by sender of notification
        if let notificationInfo = not.userInfo {
            // Safely unwrap the tag sent out by the notification sender
            if let digit = notificationInfo["digit"] as? Int {
                textField.text = String(digit)
            }
        }
    }

}

