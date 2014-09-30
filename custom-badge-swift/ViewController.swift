//
//  ViewController.swift
//  custom-badge-swift
//
//  Created by Evgenii Neumerzhitckii on 30/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    createBadges()
  }
  
  private func createBadges() {
    let badge2 = CustomBadge.customBadgeWithString("CustomBadge",
      withStringColor: UIColor.blackColor(),
      withInsetColor: UIColor.greenColor(),
      withBadgeFrame: true,
      withBadgeFrameColor: UIColor.yellowColor(),
      withScale: 1.5,
      withShining: true)
    
    // Add Badges to View
    view.addSubview(badge2)
  
    addCenterXConstraints(badge2)
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[badge2]-0@20-|",
      options: nil, metrics: nil,
      views: ["badge2":badge2 ])
    
    view.addConstraints(constraints)
    
//    view.addConstraints(constraints)
    
  }
  
  private func addCenterXConstraints(chilView: UIView) {
    view.addConstraint(NSLayoutConstraint(item: view,
      attribute: NSLayoutAttribute.CenterX,
      relatedBy: NSLayoutRelation.Equal,
      toItem:chilView,
      attribute: NSLayoutAttribute.CenterX,
      multiplier:1,
      constant:0))
  }
}

