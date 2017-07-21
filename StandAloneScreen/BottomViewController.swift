//
//  BottomViewController.swift
//  StandAloneScreen
//
//  Created by NISUM on 7/21/17.
//  Copyright © 2017 Nisum Macbook. All rights reserved.
//

import UIKit

class BottomViewController: UIViewController {
    
    @IBOutlet weak var depositeLbl: UILabel!
    
    @IBOutlet weak var varianceLbl: UILabel!
    
    @IBOutlet weak var actualLbl: UILabel!
    
    let denom = DenominationViewController()
    
    let calculateAmountNotiName = Notification.Name("CalculateAmount")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(calculateActualDeposite(not:)), name: calculateAmountNotiName, object: nil)
        

    }
    func calculateActualDeposite(not: Notification) {
        // NotificationInfo is the payload send by sender of notification
        if let notificationInfo = not.userInfo {
            // Safely unwrap the tag sent out by the notification sender
            if let totalCount = notificationInfo["total"] as? Double {
                        actualLbl.text = ("$\(totalCount)")
                        varianceLbl.text = ("$\(totalCount - 0.40)")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
