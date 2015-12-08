//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by liuxiong332 on 15/12/4.
//  Copyright © 2015年 liuxiong332. All rights reserved.
//

import XCTest

class FoodTrackerTests: XCTestCase {
    
    // MARK: FoodTracker Tests
    func testMealInitialization() {
        let potentialItem = Meal(name: "New meal", photo: nil, rating: 1)
        XCTAssertNotNil(potentialItem)
        
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "ddd", photo: nil, rating: -1)
        XCTAssertNil(badRating, "netative rating is not allowed")
    }
}
