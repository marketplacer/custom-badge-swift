//
//  ViewController.swift
//
//  This code is based on Objective-C version created by Sascha Paulus www.spaulus.com.
//  https://github.com/ckteebe/CustomBadge
//
// *** License & Copyright ***
//
// Created by Sascha Paulus www.spaulus.com on 04/2011. Version 2.0
// This tiny class can be used for free in private and commercial applications.
// Please feel free to modify, extend or distribution this class.
// If you modify it: Please send me your modified version of the class.
// Please do not sell the source code solely and keep this text in your copyright section. Thanks.
//
// If you have any questions please feel free to contact me (open@spaulus.com).
//
// -------------------------
// Converted to Swift by Evgenii Neumerzhitckii on 30/09/2014.
// Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
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
    // ---------------
    
    // Badge 1
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

  
    // Badge 2
    addCenterXConstraints(badge2)
    addCenterYConstraints(badge2)
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
  
  private func addCenterYConstraints(chilView: UIView) {
    view.addConstraint(NSLayoutConstraint(item: view,
      attribute: NSLayoutAttribute.CenterY,
      relatedBy: NSLayoutRelation.Equal,
      toItem:chilView,
      attribute: NSLayoutAttribute.CenterY,
      multiplier:1,
      constant:0))
  }
}

