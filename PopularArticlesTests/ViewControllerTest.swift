//
//  ViewControllerTest.swift
//  PopularArticlesTests
//
//  Created by DEP on 16/02/18.
//  Copyright © 2018 DEP. All rights reserved.
//

import XCTest
import WebKit

@testable import PopularArticles

class PAListViewControllerTest: XCTestCase {
    
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
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIfLauncherViewControlleriSNavigationController() {
        
        guard (UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? UINavigationController) != nil
            else {
                XCTFail("Could not instantiate vc from Main storyboard")
                return
        }
    }
    
    func testGetArticles(){
        let promise = expectation(description: "Get Network Request")
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.LAUNCHING_SEGUE_ID) as? PAListViewController {
            viewController.getArticles(completion: { (result) in
                XCTAssertTrue(result == true)
                promise.fulfill()

            })
            waitForExpectations(timeout: 50, handler: nil)

        }else{
            XCTFail("Could not instantiate vc from Main storyboard")

        }
        
    }
        
}
