//
//  DenominationViewController.swift
//  StandAloneScreen
//
//  Created by NISUM on 7/18/17.
//  Copyright © 2017 Nisum Macbook. All rights reserved.
//

import UIKit
extension Double{
    var C:Double {return self/100}
    var FIVE_C : Double {return self * 5/100}
    var TEN_C : Double {return self * 10/100}
    var TWETYFIVE_C:Double{return self * 25/100}
    var FIFTY_C:Double{return self * 50/100}
    var HUNDRED_C:Double{return self}
    var PENNIES:Double{return self *  50/100}
    var NICKEL : Double{ return self * 2}
    var DIMES : Double{return self * 5}
    var QUARTERS : Double{return self * 10}
    var Dollar1:Double{return self}
    var Dollar2:Double{return self * 2}
    var Dollar5:Double{return self * 5}
    var Dollar10:Double{return self * 10}
    var Dollar20:Double{return self * 20}
    var Dollar50:Double{return self * 50}
    var Dollar100:Double{return self * 100}
    var ACTUAL_AMOUNT:Double{return self/100}
}

class DenominationViewController: UIViewController {
    
    //Loose Coins TextFields
    @IBOutlet weak var oneCTF: UITextField!
    @IBOutlet weak var fiveCTF: UITextField!
    @IBOutlet weak var tenCTF: UITextField!
    @IBOutlet weak var twentyFiveCTF: UITextField!
    @IBOutlet weak var fiftyCTF: UITextField!
    @IBOutlet weak var oneCoinTF: UITextField!
    
    //Rolled Coins TextFields
    @IBOutlet weak var pennisTF: UITextField!
    @IBOutlet weak var nickelsTF: UITextField!
    @IBOutlet weak var dimesTF: UITextField!
    @IBOutlet weak var quarterTF: UITextField!
    
    //Bills TextFields
    @IBOutlet weak var dOneTF: UITextField!
    @IBOutlet weak var dTwoTF: UITextField!
    @IBOutlet weak var dFiveTF: UITextField!
    @IBOutlet weak var dTenTF: UITextField!
    @IBOutlet weak var dTwentyTF: UITextField!
    @IBOutlet weak var dFifftyTF: UITextField!
    @IBOutlet weak var dHundredTF: UITextField!
    var textFields : [UITextField] = [UITextField]()

    var textFieldTag = 0

    @IBOutlet weak var tempLastOpenTF: UITextField! //input field object which in edit mode
    let focusTextFieldNotiName = Notification.Name("NextField")
    let digitTextFieldNotiName = Notification.Name("EnterDigit")
    let showKeyBoardNotiName = Notification.Name("ShowKeyboard")
    let calculateAmountNotiName = Notification.Name("CalculateAmount")

    var digiTag = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFields = view.subviews.filter{($0 is UITextField)} as! [UITextField]
        seTextFieldsBorder()
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(updateField(not:)), name: focusTextFieldNotiName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateField(not:)), name: digitTextFieldNotiName, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        tempLastOpenTF = textField
        tempLastOpenTF.setBottomBorder()

        return true
    }
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()

        tempLastOpenTF = textField
        NotificationCenter.default.post(name: showKeyBoardNotiName, object: self, userInfo: ["type": 1])


    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        calculateTotalAmount()
    }
    func updateField(not: Notification) {
        // NotificationInfo is the payload send by sender of notification
        if let notificationInfo = not.userInfo {
            // Safely unwrap the tag sent out by the notification sender
            if let tag = notificationInfo["tag"] as? Int {
                focusTextField(nextPrev: tag)

            }
            else if let digit = notificationInfo["digit"] as? Int {
                valueTextField(digit: digit)
            }

        }
    }
    
    func seTextFieldsBorder(){
        for item in textFields{
            item.clearBottomBorder()
        }
    }
    func checkEmptyTextFields(){
        for tag in 1..<17 {
            let tf = tempLastOpenTF.superview!.viewWithTag(tag)
            if (tf != nil){
                if tempLastOpenTF.text?.characters.count == 0 {
                tempLastOpenTF.clearBottomBorder()
                }
                else{
                    tempLastOpenTF.setBottomBorder()
                }
            }
        }
    }
    
    
    func highlightLables(tag: Int){
        for i: UIView in view.subviews {

            if (i is UITextField) {
                let newLbl: UITextField? = (i as? UITextField)
                for tag in 1..<17 {
                    if newLbl?.tag == tag {
                        let bc = tag+100
                        
                        if newLbl?.text?.characters.count == 0 {
                            newLbl?.clearBottomBorder()
                            if let theLabel = self.view.viewWithTag(bc) as? UILabel {
                                labelColor(label: theLabel, color: UIColor.lightGray)
                            }
                            
                        }
                        else{
                            if let theLabel = self.view.viewWithTag(bc) as? UILabel {
                                labelColor(label: theLabel, color: UIColor.blue)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func labelColor(label: UILabel, color: UIColor){
        label.textColor = color
    }

    func activeLabel(tag: Int){
        var tag = tag
        tag = tag+100
        if let theLabel = self.view.viewWithTag(tag) as? UILabel {
            labelColor(label: theLabel, color: UIColor.blue)

        }
    }
    
    func calculateTotalAmount(){
        var totalCount: Double = 0.00
                for i: UIView in view.subviews {
                    if (i is UITextField) {
                        let textField: UITextField? = (i as? UITextField)
                        if ((textField!.text?.characters.count)! > 0){
                            let tag = textField?.tag
                            if(tag == 1){
                            totalCount += Double((textField?.text!)!)!.C
                            }
                            else if(tag == 2){
                                totalCount += Double((textField?.text!)!)!.FIVE_C
                            }
                            else if(tag == 3){
                                totalCount += Double((textField?.text!)!)!.TEN_C
                            }
                            else if(tag == 4){
                                totalCount += Double((textField?.text!)!)!.TWETYFIVE_C
                            }
                            else if(tag == 5){
                                totalCount += Double((textField?.text!)!)!.FIFTY_C
                           }
                            else if(tag == 6){
                                totalCount += Double((textField?.text!)!)!.HUNDRED_C
                            }
                            else if(tag == 7){
                                totalCount += Double((textField?.text!)!)!.PENNIES
                           }
                            else if(tag == 8){
                                totalCount += Double((textField?.text!)!)!.NICKEL

                             }
                            else if(tag == 9){
                                totalCount += Double((textField?.text!)!)!.DIMES
                             }
                            else if(tag == 10){
                                totalCount += Double((textField?.text!)!)!.QUARTERS
                             }
                            else if(tag == 11){
                                totalCount += Double((textField?.text!)!)!.Dollar1

                             }
                            else if(tag == 12){
                                totalCount += Double((textField?.text!)!)!.Dollar2

                             }
                            else if(tag == 13){
                                totalCount += Double((textField?.text!)!)!.Dollar5

                             }
                            else if(tag == 14){
                                totalCount += Double((textField?.text!)!)!.Dollar10

                             }
                            else if(tag == 15){
                                totalCount += Double((textField?.text!)!)!.Dollar20

                            }
                            else if(tag == 16){
                                totalCount += Double((textField?.text!)!)!.Dollar50

                            }
                            else if(tag == 17){
                                totalCount += Double((textField?.text!)!)!.Dollar100

                            }

                        }
                    }
                }
            NotificationCenter.default.post(name: calculateAmountNotiName, object: self, userInfo: ["total": totalCount])

}

    
    func focusTextField(nextPrev:Int){
        tempLastOpenTF.setBottomBorder()
        var nextResponder: UIResponder!
        var tag = 0
        tag = tempLastOpenTF.tag + nextPrev
        digiTag = tag

        if tag <= 17 {
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.setBottomBorder()
            highlightLables(tag: tag)
            nextResponder.becomeFirstResponder()
            activeLabel(tag: tag)
        }
       }
    
    func valueTextField(digit: Int){
        
        var nextResponder: UIResponder!
        let tag = digiTag
        
        if(tag == 1){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)
            nextResponder.becomeFirstResponder()
        }
        else if(tag == 2){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 3){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 4){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 5){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 6){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 7){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 8){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 9){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 10){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 11){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 12){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)
            nextResponder.becomeFirstResponder()
        }
        else if(tag == 13){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 14){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)
            nextResponder.becomeFirstResponder()
        }
        else if(tag == 15){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 16){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)

            nextResponder.becomeFirstResponder()
        }
        else if(tag == 17){
            nextResponder = tempLastOpenTF.superview!.viewWithTag(tag)!
            tempLastOpenTF.text = String(digit)
            nextResponder.becomeFirstResponder()
        }
        else
        {
        }
        
        
    }

}
