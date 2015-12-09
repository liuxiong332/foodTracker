//
//  ViewController.swift
//  FoodTracker
//
//  Created by liuxiong332 on 15/12/4.
//  Copyright © 2015年 liuxiong332. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!

    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
    This value is either passed by `MealTableViewController` in `prepareSegue(_:sender:` 
    or constructed as part of adding new meal.
    */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        
        if let meal = self.meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        checkValidMealName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // dismiss the image picker cotroller if user cancelled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        //HIde the keyboard
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)

    }
    
    @IBAction func cancel(sender: AnyObject) {
        if presentingViewController is UINavigationController {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: Navigation
    // This method let you config your view controller before it presents
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender === saveButton {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
}

