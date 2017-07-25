//
//  KeyBoardViewController.swift
//  StandAloneScreen
//
//  Created by NISUM on 7/19/17.
//  Copyright © 2017 Nisum Macbook. All rights reserved.
//

import UIKit

class KeyBoardViewController: UIViewController {
    
    @IBOutlet weak var oneBtn: UIButton!
    @IBOutlet weak var twoBtn: UIButton!
    @IBOutlet weak var threeBtn: UIButton!
    @IBOutlet weak var fourBtn: UIButton!
    @IBOutlet weak var fiveBtn: UIButton!
    @IBOutlet weak var sixBtn: UIButton!
    @IBOutlet weak var sevenBtn: UIButton!
    @IBOutlet weak var eightBtn: UIButton!
    @IBOutlet weak var nineBtn: UIButton!
    @IBOutlet weak var zeroBtn: UIButton!
    @IBOutlet weak var doubeZeroBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!


    let notificationName = Notification.Name("NextField")
    let digitTextFieldNotiName = Notification.Name("EnterDigit")
    let showKeyBoardNotiName = Notification.Name("ShowKeyboard")
    let totalTextFieldNotiName = Notification.Name("TotalEnterDigit")

    let movement: CGFloat = 20.0
    
    var type = 3
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        // Do any additional setup after loading the view, typically from a nib.
        makeKeyboardHide()
        NotificationCenter.default.addObserver(self, selector: #selector(makeKeyboardVisible(not:)), name: showKeyBoardNotiName, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //show keyboard
    func makeKeyboardVisible(not:Notification){
        self.view.alpha = 1
        if let notificationInfo = not.userInfo {
            // Safely unwrap the tag sent out by the notification sender
            if let keyType = notificationInfo["type"] as? Int {
                type = keyType
            }
        }
    }
    
    //Hide keyboard
    func makeKeyboardHide(){
        self.view.alpha = 0
    }
    
    @IBAction func doneButton(_ sender: Any) {
        makeKeyboardHide()
    }
 
    //Move to next input field
    @IBAction func nextField(){
        if type == 1 {
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["tag": 1])
        }
    }
    
    
    //Move to previous input field
    @IBAction func previousField(){
        if type == 1 {
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["tag": -1])
        }
    }
    
    //Button pressed
    @IBAction func digitsPressed(_ sender: UIButton){
        
        var digitValue = 0
        digitValue = sender.tag
        if sender.tag == 500 {
            digitValue = 0
        }
        else if sender.tag == 501 {
            digitValue = -2
        }
        else if sender.tag == 502 {
             digitValue = -1
        }
        
        if type == 0 {
        NotificationCenter.default.post(name: totalTextFieldNotiName, object: self, userInfo: ["digit": digitValue])
        }
        else {
            NotificationCenter.default.post(name: digitTextFieldNotiName, object: self, userInfo: ["digit": digitValue])

        }
    }
    
}
