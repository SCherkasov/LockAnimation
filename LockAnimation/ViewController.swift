//
//  ViewController.swift
//  LockAnimation
//
//  Created by Stanislav Cherkasov on 3/20/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var currentImage: UIImageView!
  
  var imageViews: [UIImageView] = []
  
  var leftImageView: UIImageView {
    return self.imageViews[0]
  }
  
  var rightImageView: UIImageView {
    return self.imageViews[1]
  }
  
  enum DoorState {
    case opened
    case closed
  }
  
  var doorSate = DoorState.closed
  
  @IBOutlet var welcomeView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.imageViews = UIImage(named: "lock")!.divideIntoTwoVertiсalParts()
      .map {
        UIImageView.init(image: $0)
    }
    
    let width = self.welcomeView.frame.width
    imageViews[0].frame = CGRect.init(
      x: 0,
      y: 0,
      width: width / 2.0,
      height: width
    )
    
    imageViews[1].frame = CGRect.init(
      x: width / 2.0,
      y: 0,
      width: width / 2.0,
      height: width
    )
    
    imageViews[0].alpha = 0.5
    imageViews[1].alpha = 0.5
    
    self.welcomeView.addSubview(imageViews[0])
    self.welcomeView.addSubview(imageViews[1])
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Jenia, please help here:
    // how it make correct?? (instead - 137.0 & - 37.0)
    //imageViews[0].center.x = welcomeView.center.x - 137.0
    //imageViews[1].center.x = welcomeView.center.x - 37.0
    
    self.leftImageView.frame.origin = self.leftViewClosedOrigin()
    self.rightImageView.frame.origin = self.rightViewClosedOrigin()
  }
  
  func leftViewOpenedOrigin() -> CGPoint {
    return CGPoint(
      x: self.welcomeView.bounds.origin.x - self.welcomeView.bounds.width / 2.0,
      y: self.welcomeView.bounds.origin.y
    )
  }
  
  func rightViewOpenedOrigin() -> CGPoint {
    return CGPoint(
      x: self.welcomeView.bounds.origin.x + 1 * self.welcomeView.bounds.width,
      y: self.welcomeView.bounds.origin.y
    )
  }
  
  func leftViewClosedOrigin() -> CGPoint {
    return CGPoint(
      x: self.welcomeView.bounds.origin.x,
      y: self.welcomeView.bounds.origin.y
    )
  }
  
  func rightViewClosedOrigin() -> CGPoint {
    return CGPoint(
      x: self.welcomeView.bounds.origin.x + 0.5 * self.welcomeView.bounds.width,
      y: self.welcomeView.bounds.origin.y
    )
  }
  
  @IBAction func actionButton(_ sender: UIButton) {
    switch self.doorSate {
    case .opened:
      self.transition(to: .closed)
    case .closed:
      self.transition(to: .opened)
    }
  }
  
  func transition(to nextDoorState: DoorState) {
    
    var onActionAnimation: (() -> Void)!
    let onActionCompleteAnimation: ((Bool) -> Void) = { _ in }
    
    /*
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath: @"opacity"];
    alphaAnimation.fillMode = kCAFillModeForwards;
    
    alphaAnimation.fromValue = NUM_FLOAT(0);
    self.view.layer.opacity = 1;
    
    [self.view.layer addAnimation: alphaAnimation forKey: @"fade"];
    */
    
    print("\(self.leftImageView.layer.anchorPoint), \(self.leftImageView.layer.position)")
    
    var toPoint:CGPoint = CGPoint(x: 0.0, y: -50.0)
    var fromPoint:CGPoint = CGPoint.zero
    var movement = CABasicAnimation(keyPath: "movement")
    movement.isAdditive = true
    movement.fromValue = fromPoint
    movement.toValue = toPoint
    movement.duration = 0.3
    
    
    
    let animation = CABasicAnimation(keyPath: "position")
    animation.fromValue = self.leftImageView.frame.origin // self.leftImageView.frame.origin.x + self.rightImageView.frame.width / 4.0
    animation.toValue = CGPoint(x: self.leftImageView.frame.origin.x - 50 , y: self.leftImageView.frame.origin.y)
    animation.duration = 5;
    
    self.leftImageView.layer.add(movement, forKey: "move")
    
    /*
    
    if nextDoorState == .opened {
      onActionAnimation = {
        self.doorSate = .opened
        
     animation.fromValue = self.leftViewOpenedOrigin()
     animation.toValue = self.rightViewOpenedOrigin()
        
        self.leftImageView.frame.origin = self.leftViewOpenedOrigin()
        self.rightImageView.frame.origin = self.rightViewOpenedOrigin()
        
        self.leftImageView.alpha = 0
        self.leftImageView.alpha = 1
        
        //self.rightImageView.alpha = 0.0
      }
    } else {
      onActionAnimation = {
        self.doorSate = .closed
        
        self.leftImageView.frame.origin = self.leftViewClosedOrigin()
        self.rightImageView.frame.origin = self.rightViewClosedOrigin()
        
        self.leftImageView.alpha = 1
        self.leftImageView.alpha = 0
        
        
        //self.leftImageView.alpha = 0.5
        //self.rightImageView.alpha = 0.5
      }
    }
 
     */
    /*
    UIView.setAnimationBeginsFromCurrentState(true)
    
    
    UIView.animate(
      withDuration: 1.0,
      delay: 0.3,
      options: [],
      animations: onActionAnimation,
      completion: onActionCompleteAnimation)
 
 */
  }
}

