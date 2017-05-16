//
//  Card.swift
//  DemoMemoryGame
//
//  Created by Manish on 31/01/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class Card: UIView {

   
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self)
    }();
    lazy var gravity:UIGravityBehavior = {
        let lazyGravity = UIGravityBehavior()
        lazyGravity.gravityDirection=CGVectorMake(0, 0.1);
        return lazyGravity
    }()
  
  
    
    
    
    enum CardFace {
        case Front
        case Back
    }
    var cardIndex:Int=0;
    var tagValue:String!
    var cardFace:CardFace! = .Back
    var back: UIImageView!
    var front: UIImageView!
    var TabGesture:UITapGestureRecognizer? = nil
    var timeToFlip:Double=0.85;
    var TabbedBlock: ((card:Card)->())?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //just call this function only once
     func UITapGesture() -> Void {
        TabGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped));
        TabGesture?.numberOfTapsRequired=1;
        self.addGestureRecognizer(TabGesture!);
    }
     func setCardFrontFace(path:String) -> Void {
        front = UIImageView(image: UIImage(named: path))
        
        back = UIImageView(image: UIImage(named: "MemoryGame/Mainface"))
        self.addSubview(back);
       
    }
     func removeWithEffect() -> Void {
        animator.addBehavior(gravity)
        
          gravity.addItem(self)
    }
    func cardFlipBack() -> Void {
        UIView.transitionFromView(front, toView: back, duration: timeToFlip, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
        cardFace = .Back;
    }
     func cardTapped() {
        weak var reference=self;
        if (cardFace == .Back) {
            UIView.transitionFromView(back, toView: front, duration: timeToFlip, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
            cardFace = .Front;
            if((TabbedBlock) != nil)
            {
                TabbedBlock!(card: reference!);
            }
         
        } else {
            UIView.transitionFromView(front, toView: back, duration: timeToFlip, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
            cardFace = .Back;
            
        }
      
    }
}
