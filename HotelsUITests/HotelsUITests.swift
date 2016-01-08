//
//  HotelsUITests.swift
//  HotelsUITests
//
//  Created by Rob Norback on 1/7/16.
//  Copyright © 2016 Rob Norback. All rights reserved.
//

import XCTest

class HotelsUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.sharedDevice().orientation = .Portrait
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSegmentedControl() {
        app.segmentedControls.element.tap()
        let text = app.staticTexts["Days Inn Bloomington"]
        XCTAssertTrue(text.exists, "Should be on the Minneapolis screen")
    }
    
    func testDetailSegue() {
        app.staticTexts["Palace Hotel - Luxury Collection"].tap()
        let detailTitleLabel = app.navigationBars.staticTexts["Hotel Details"]
        XCTAssertTrue(detailTitleLabel.exists, "Should be on the Hotel Detail screen")
    }
    
    func testMapIsVisible() {
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Hilton San Francisco Downtown/Financial District"].swipeUp()
        tablesQuery.cells.containingType(.StaticText, identifier:"Best Western Plus Grosvenor Airport Hotel").childrenMatchingType(.StaticText).matchingIdentifier("Best Western Plus Grosvenor Airport Hotel").elementBoundByIndex(0).tap()
        app.buttons["View Hotel Location"].tap()
        
        let mapQuery = app.maps
        XCTAssertTrue(mapQuery.element.exists, "Map should be present")
        
    }
}
