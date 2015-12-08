//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by liuxiong332 on 15/12/8.
//  Copyright © 2015年 liuxiong332. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    // MARK: Properties
    var meals = [Meal]()
    
    func loadSampleMeals() {
        let photo = UIImage(named: "defaultPhoto")
        let meal = Meal(name: "Default", photo: photo, rating: 2)!
        meals += [meal]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeals()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealTableViewCell", forIndexPath: indexPath) as! MealTableViewCell
        
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.ratingControl.rating = meal.rating
        cell.photoImageView.image = meal.photo
        
        return cell
    }
}