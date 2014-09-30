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
    let customBadge2 = CustomBadge.customBadgeWithString("CustomBadge",
      withStringColor: UIColor.blackColor(),
      withInsetColor: UIColor.greenColor(),
      withBadgeFrame: true,
      withBadgeFrameColor: UIColor.yellowColor(),
      withScale: 1.5,
      withShining: true)
    
    
    println("badge size: \(customBadge2.frame.size)")
    
    
    // Set frames
    customBadge2.frame = CGRect(
      origin: CGPoint(
        x: view.frame.size.width / 2 - customBadge2.frame.size.width / 2,
        y: 110),
      size: customBadge2.frame.size)
    
    // Add Badges to View
    view.addSubview(customBadge2)
  }
}

