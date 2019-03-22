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
    
    self.imageViews = UIImage(named: "lock")!.divideIntoTwoVertialParts()
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

  @IBAction func actionButton(_ sender: UIButton) {
    switch self.doorSate {
    case .opened:
      self.doorSate = .closed
      self.transition(to: .closed)
    case .closed:
      self.doorSate = .opened
      self.transition(to: .opened)
    }
  }
  
  func transition(to nextDoorState: DoorState) {
    if nextDoorState == .opened {
      UIView.animate(withDuration: 1.0, delay: 0.3, options: [], animations: {
        self.imageViews[0].center.x -= self.welcomeView.bounds.width / 2
        self.imageViews[1].center.x += self.welcomeView.bounds.width / 2
        self.imageViews[0].alpha = 0.0
        self.imageViews[1].alpha = 0.0
      }, completion: nil)
    } else {
        UIView.animate(withDuration: 1.0, delay: 0.3, options: [], animations: {
        self.imageViews[0].center.x += self.welcomeView.bounds.width / 2
        self.imageViews[1].center.x -= self.welcomeView.bounds.width / 2
         self.imageViews[0].alpha = 0.5
          self.imageViews[1].alpha = 0.5
        }, completion: nil)
      }
    }
  }

