//
//  RatingControl.swift
//  FoodTracker
//
//  Created by liuxiong332 on 15/12/7.
//  Copyright © 2015年 liuxiong332. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Properties
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var stars = 5
    var spacing = 5
    
    var ratingButtons = [UIButton]()
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<stars {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Selected, .Highlighted])
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: "rantingButtonTapped:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }

    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    
    func rantingButtonTapped(sender: UIButton) {
        rating = ratingButtons.indexOf(sender)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of button is less than rating, that button should be selected.
            button.selected = index < rating
        }
    }
}
    