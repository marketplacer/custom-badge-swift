//
//  CustomBadge.swift
//  custom-badge-swift
//
//  Created by Evgenii Neumerzhitckii on 30/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class CustomBadge: UIView {
  private var badgeText: String
  private let badgeTextColor: UIColor
  private let badgeFrame = true
  private let badgeFrameColor: UIColor
  private let badgeInsetColor: UIColor
  private let badgeCornerRoundness = 0.4
  private let badgeScaleFactor: CGFloat
  private let badgeShining:Bool

  init(badgeString: String, withScale scale: CGFloat, withShining shining: Bool) {
    badgeText = badgeString
    badgeTextColor = UIColor.whiteColor()
    badgeFrameColor = UIColor.whiteColor()
    badgeInsetColor = UIColor.redColor()
    badgeScaleFactor = scale
    badgeShining = shining
    
    super.init(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    contentScaleFactor = UIScreen.mainScreen().scale
    backgroundColor = UIColor.clearColor()
    
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // Use this method if you want to change the badge text after the first rendering
  func autoBadgeSizeWithString(badgeString: String)
  {
    var retValue: CGSize
    let stringSize = (badgeString as NSString).sizeWithAttributes(
      [badgeString:UIFont.boldSystemFontOfSize(12)])
    
    if countElements(badgeString) >= 2 {
      let flexSpace:CGFloat = CGFloat(countElements(badgeString))
      let rectWidth:CGFloat = 25 + (stringSize.width + flexSpace)
      let rectHeight:CGFloat = 25
      
      retValue = CGSize(width: rectWidth * badgeScaleFactor, height: rectHeight * badgeScaleFactor)
    } else {
      retValue = CGSize(width: 25 * badgeScaleFactor, height: 25 * badgeScaleFactor)
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, retValue.width, retValue.height)
    self.badgeText = badgeString
    setNeedsDisplay()
  }
}
