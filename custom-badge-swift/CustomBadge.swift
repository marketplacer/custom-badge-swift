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
  private let badgeFrame: Bool
  private let badgeFrameColor: UIColor
  private let badgeInsetColor: UIColor
  private let badgeCornerRoundness = 0.4
  private let badgeScaleFactor: CGFloat
  private let badgeShining:Bool

  // I recommend to use the allocator customBadgeWithString
  init(badgeString: String, withScale scale: CGFloat, withShining shining: Bool) {
    
    self.badgeText = badgeString
    self.badgeTextColor = UIColor.whiteColor()
    self.badgeFrameColor = UIColor.whiteColor()
    self.badgeInsetColor = UIColor.redColor()
    self.badgeScaleFactor = scale
    self.badgeShining = shining
    self.badgeFrame = true
    
    super.init(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    contentScaleFactor = UIScreen.mainScreen().scale
    backgroundColor = UIColor.clearColor()
  }
  
  // I recommend to use the allocator customBadgeWithString
  init(badgeString: String, withStringColor stringColor:UIColor, withInsetColor insetColor:UIColor,
    withBadgeFrame badgeFrameYesNo:Bool, withBadgeFrameColor frameColor:UIColor,
    withScale scale:CGFloat, withShining shining:Bool) {
      
    self.badgeText = badgeString
    self.badgeTextColor = stringColor
    self.badgeFrameColor = frameColor
    self.badgeInsetColor = insetColor
    self.badgeScaleFactor = scale
    self.badgeShining = shining
    self.badgeFrame = badgeFrameYesNo
      
    super.init(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    contentScaleFactor = UIScreen.mainScreen().scale
    backgroundColor = UIColor.clearColor()
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Creates a Badge with a given Text
  class func customBadgeWithString(badgeString: String) -> CustomBadge
  {
    return CustomBadge(badgeString: badgeString, withScale: 1, withShining: true)
  }
  
  // Creates a Badge with a given Text, Text Color, Inset Color, Frame (YES/NO) and Frame Color
  class func customBadgeWithString(badgeString: String, withStringColor stringColor:UIColor,
    withInsetColor insetColor:UIColor,
    withBadgeFrame badgeFrameYesNo:Bool, withBadgeFrameColor frameColor:UIColor,
    withScale scale:CGFloat, withShining shining:Bool) -> CustomBadge
  {
    return CustomBadge(badgeString: badgeString, withStringColor: stringColor,
      withInsetColor: insetColor, withBadgeFrame: badgeFrameYesNo,
      withBadgeFrameColor: frameColor, withScale: scale, withShining: shining)
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
