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
    }
    
   
    func testIfLauncherViewControlleriSNavigationController() {
        
        guard (UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? UINavigationController) != nil
            else {
                XCTFail("Could not instantiate vc from Main storyboard")
                return
        }
    }
    
    // test if getArticles returns article list 
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
    
    // test table view rows will be shown if response has more than one article
    func testThatTableViewShownIfValidResponse(){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.LAUNCHING_SEGUE_ID) as? PAListViewController {
            
            let articleDistionary = ["url": "https://www.google.co.in",
                                     "title": "test title",
                                     "byline": "Anonymous",
                                     "published_date": "2018-02-03"] as [String : AnyObject]
            viewController.arrRes.append(articleDistionary)
            
            viewController.loadView()
            
            XCTAssertTrue(viewController.tableViewNews.numberOfRows(inSection: 0) > 0 )

            
        }else{
            XCTFail("Could not instantiate vc from Main storyboard")
            
        }
        
    }
    
    // test table view rows will not be shown if response no article
    func testThatNoTableViewRowIfInValidResponse(){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.LAUNCHING_SEGUE_ID) as? PAListViewController {
            
            
            viewController.loadView()
            
            XCTAssertTrue(viewController.tableViewNews.numberOfRows(inSection: 0) == 0 )
            
            
        }else{
            XCTFail("Could not instantiate vc from Main storyboard")
            
        }
        
    }
        
}
