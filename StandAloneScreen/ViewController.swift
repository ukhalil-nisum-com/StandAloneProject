//
//  ViewController.swift
//  StandAloneScreen
//
//  Created by NISUM on 7/18/17.
//  Copyright © 2017 Nisum Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sidePanelContainerView: UIView!
    
    @IBOutlet weak var totalContainerView: UIView!

    @IBOutlet weak var denominatyionContainerView: UIView!
    @IBOutlet weak var totalButton: UIButton!
    
    @IBOutlet weak var denominationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Count Cash Deposit -#302"
        // Do any additional setup after loading the view, typically from a nib.
        
        self.totalContainerView.alpha = 1
        self.denominatyionContainerView.alpha = 0
        
        let showBorderLine = UIView(frame: CGRect(x:0, y:totalButton.frame.size.height, width:totalButton.frame.size.width, height:2))
        showBorderLine.backgroundColor = UIColor.blue
        totalButton.addSubview(showBorderLine)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonAction(_ sender: UIButton) {
        showButtonBottomBorder(tag: sender.tag)
        if sender.tag == 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.totalContainerView.alpha = 1
                self.denominatyionContainerView.alpha = 0
            })
        } else {
            
                UIView.animate(withDuration: 0.5, animations: {
                self.totalContainerView.alpha = 0
                self.denominatyionContainerView.alpha = 1
                
            })
        }
   
    }
    
    func showButtonBottomBorder(tag: Int){
        if tag == 1{
            let showBorderLine = UIView(frame: CGRect(x:0, y:totalButton.frame.size.height, width:totalButton.frame.size.width, height:2))
            showBorderLine.backgroundColor = UIColor.blue
            totalButton.addSubview(showBorderLine)
            
            let hideBorderLine = UIView(frame: CGRect(x:0, y:denominationButton.frame.size.height, width:denominationButton.frame.size.width, height:2))
            hideBorderLine.backgroundColor = UIColor.white
            denominationButton.addSubview(hideBorderLine)
        }
        else{
            let hideBorderLine = UIView(frame: CGRect(x:0, y:totalButton.frame.size.height, width:totalButton.frame.size.width, height:2))
            hideBorderLine.backgroundColor = UIColor.white
            totalButton.addSubview(hideBorderLine)
            
            let showBorderLine = UIView(frame: CGRect(x:0, y:denominationButton.frame.size.height, width:denominationButton.frame.size.width, height:2))
            showBorderLine.backgroundColor = UIColor.blue
            denominationButton.addSubview(showBorderLine)
        }
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blue.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func clearBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }

}
