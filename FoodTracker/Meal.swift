//
//  Meal.swift
//  FoodTracker
//
//  Created by liuxiong332 on 15/12/8.
//  Copyright © 2015年 liuxiong332. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Types
    
    struct PropertyType {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    // MARK: Archiving Path
    
    static let DocumentDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiveURL = DocumentDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        super.init()
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyType.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyType.photoKey)
        aCoder.encodeObject(rating, forKey: PropertyType.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyType.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyType.photoKey) as? UIImage
        let rating = aDecoder.decodeObjectForKey(PropertyType.ratingKey) as! Int
        self.init(name: name, photo: photo, rating: rating)
    }
}
