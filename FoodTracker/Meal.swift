//
//  Meal.swift
//  FoodTracker
//
//  Created by liuxiong332 on 15/12/8.
//  Copyright © 2015年 liuxiong332. All rights reserved.
//

import UIKit

class Meal {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}
