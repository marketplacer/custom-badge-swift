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
    let badge1 = CustomBadge.customBadgeWithString("2",
      withStringColor: UIColor.whiteColor(),
      withInsetColor: UIColor.redColor(),
      withBadgeFrame: true,
      withBadgeFrameColor: UIColor.whiteColor(),
      withScale: 1.0,
      withShining: true)
    
    let badge2 = CustomBadge.customBadgeWithString("CustomBadge",
      withStringColor: UIColor.blackColor(),
      withInsetColor: UIColor.greenColor(),
      withBadgeFrame: true,
      withBadgeFrameColor: UIColor.yellowColor(),
      withScale: 1.5,
      withShining: true)
    
    // Add badges to view
    view.addSubview(badge2)
    view.addSubview(badge1)
    
    // Position badges
    
    
    view.addConstraint(NSLayoutConstraint(item: badge1,
      attribute: NSLayoutAttribute.CenterY,
      relatedBy: NSLayoutRelation.Equal,
      toItem:badge2,
      attribute: NSLayoutAttribute.Top,
      multiplier:1,
      constant:2))
    
    view.addConstraint(NSLayoutConstraint(item: badge1,
      attribute: NSLayoutAttribute.CenterX,
      relatedBy: NSLayoutRelation.Equal,
      toItem:badge2,
      attribute: NSLayoutAttribute.Trailing,
      multiplier:1,
      constant:-2))
    
//    var constraints = NSLayoutConstraint.constraintsWithVisualFormat("[badge2][badge1]",
//      options: nil, metrics: nil,
//      views: ["badge1": badge1, "badge2": badge2])
//    view.addConstraints(constraints)
//    
//    constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[badge2][badge1]",
//      options: nil, metrics: nil,
//      views: ["badge1": badge1, "badge2": badge2])
//    view.addConstraints(constraints)
    
  
    addCenterXConstraints(badge2)
    var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[badge2]-0@20-|",
      options: nil, metrics: nil,
      views: ["badge2": badge2])
    
    view.addConstraints(constraints)
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

