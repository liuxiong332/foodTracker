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
        
        if let saveMeals = loadMeals() {
            meals = saveMeals
        } else {
            loadSampleMeals()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem()
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
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            meals.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveMeals()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            if let selectedCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let detailViewController = segue.destinationViewController as! MealViewController
                detailViewController.meal = meals[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealViewController,
        let meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .Bottom)
            } else {
                meals += [meal]
                let indexPath = NSIndexPath(forRow: meals.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)
            }
            saveMeals()
        }
    }
    
    // MARK: NSCoding
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
}
