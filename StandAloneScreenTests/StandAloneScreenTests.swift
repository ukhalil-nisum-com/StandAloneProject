//
//  StandAloneScreenTests.swift
//  StandAloneScreenTests
//
//  Created by NISUM on 7/18/17.
//  Copyright © 2017 Nisum Macbook. All rights reserved.
//

import XCTest
@testable import StandAloneScreen

class StandAloneScreenTests: XCTestCase {
    
    let denom = DenominationViewController()
    let keyB = KeyBoardViewController()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
   
        let selectedTextField = UITextField()
        
        let testValue = 60
        selectedTextField.text = "3"
        selectedTextField.tag = 14
        
        let getValue = denom.calculateTotalAmountTest(tag: selectedTextField.tag, textField: selectedTextField)
        
        XCTAssert(Int(getValue) == testValue)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
