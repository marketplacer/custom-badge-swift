//
//  CustomBadge.swift
//
//  This code is based on Objective-C version created by Sascha Paulus www.spaulus.com.
//  https://github.com/ckteebe/CustomBadge
//
//  Converted to Swift by Evgenii Neumerzhitckii on 30/09/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class CustomBadge: UIView {
  private var badgeText: String
  private let badgeTextColor: UIColor
  private let badgeFrame: Bool
  private let badgeFrameColor: UIColor
  private let badgeInsetColor: UIColor
  private let badgeCornerRoundness: CGFloat = 0.4
  private let badgeScaleFactor: CGFloat
  private let badgeShining:Bool
  
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
      
    setTranslatesAutoresizingMaskIntoConstraints(false)
    
    contentScaleFactor = UIScreen.mainScreen().scale
    backgroundColor = UIColor.clearColor()
    invalidateIntrinsicContentSize()
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Padding between viewedge and the border like
  private func padding(forRect rect: CGRect) -> CGFloat {
    return CGRectGetMaxY(rect) * 0.10
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
  
  override func intrinsicContentSize() -> CGSize {
    var size: CGSize
    let stringSize = (badgeText as NSString).sizeWithAttributes(
      [NSFontAttributeName:UIFont.boldSystemFontOfSize(12)])
    
    if countElements(badgeText) >= 2 {
      let flexSpace:CGFloat = CGFloat(countElements(badgeText))
      let rectWidth:CGFloat = 25 + (stringSize.width + flexSpace)
      let rectHeight:CGFloat = 25
      
      size = CGSize(width: rectWidth * badgeScaleFactor, height: rectHeight * badgeScaleFactor)
    } else {
      size = CGSize(width: 25 * badgeScaleFactor, height: 25 * badgeScaleFactor)
    }

    return size
  }
  
  override func alignmentRectInsets() -> UIEdgeInsets {
    let puffer = padding(forRect: bounds)
    return UIEdgeInsets(top: puffer, left: puffer, bottom: puffer, right: puffer)
  }
  
  private func drawArc(context: CGContextRef, withRect rect:CGRect) {
    let radius = CGRectGetMaxY(rect) * badgeCornerRoundness
    let puffer = padding(forRect: rect)
    let maxX = CGRectGetMaxX(rect) - puffer
    let maxY = CGRectGetMaxY(rect) - puffer
    let minX = CGRectGetMinX(rect) + puffer
    let minY = CGRectGetMinY(rect) + puffer
    let pi = CGFloat(M_PI)
    
    CGContextAddArc(context, maxX - radius, minY + radius, radius, pi + (pi / 2), 0, 0)
    CGContextAddArc(context, maxX - radius, maxY - radius, radius, 0, pi / 2, 0)
    CGContextAddArc(context, minX + radius, maxY - radius, radius, pi / 2, pi, 0)
    CGContextAddArc(context, minX+radius, minY+radius, radius, pi, pi + pi / 2, 0)
  }
  
  // Draws the Badge with Quartz
  private func drawRoundedRectWithContext(context: CGContextRef, withRect rect:CGRect)
  {
    CGContextSaveGState(context)
      
    CGContextBeginPath(context)
    CGContextSetFillColorWithColor(context, badgeInsetColor.CGColor)
    
    drawArc(context, withRect: rect)
    
    CGContextSetShadowWithColor(context, CGSizeMake(1.0,1.0), 3, UIColor.blackColor().CGColor)
    CGContextFillPath(context)
    
    CGContextRestoreGState(context)
  }
  
  // Draws the Badge Shine with Quartz
  private func drawShineWithContext(context: CGContextRef, withRect rect:CGRect)
  {
    CGContextSaveGState(context)
    
    CGContextBeginPath(context)
    drawArc(context, withRect: rect)
    CGContextClip(context);
    
    let num_locations: size_t = 2
    let locations:[CGFloat] = [0.0, 0.4]
    let components:[CGFloat] = [0.92, 0.92, 0.92, 1.0, 0.82, 0.82, 0.82, 0.4]
    
    let cspace = CGColorSpaceCreateDeviceRGB()
    let gradient = CGGradientCreateWithColorComponents (cspace, components,
      locations, num_locations)
    
    let sPoint = CGPoint()
    let maxY = CGRectGetMaxY(rect) - padding(forRect: rect)
    let ePoint = CGPoint(x: 0, y: maxY)
   
    CGContextDrawLinearGradient (context, gradient, sPoint, ePoint, 0)
    
    CGContextRestoreGState(context)
  }
  
  // Draws the Badge Frame with Quartz
  private func drawFrameWithContext(context: CGContextRef, withRect rect:CGRect) {
    CGContextBeginPath(context)
    
    var lineSize: CGFloat = 2
    
    if badgeScaleFactor > 1 {
      lineSize += badgeScaleFactor * 0.25
    }
    
    CGContextSetLineWidth(context, lineSize)
    CGContextSetStrokeColorWithColor(context, badgeFrameColor.CGColor)
    drawArc(context, withRect: rect)
    CGContextClosePath(context)
    CGContextStrokePath(context) // Clear the current path
  }
  
  override func drawRect(rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
   
    drawRoundedRectWithContext(context, withRect: rect)
  
    if badgeShining {
      drawShineWithContext(context, withRect: rect)
    }
  
    if badgeFrame  {
      drawFrameWithContext(context, withRect: rect)
    }
  
    if !badgeText.isEmpty {
      var sizeOfFont = 13.5 * badgeScaleFactor
    
      if countElements(badgeText) < 2 {
        sizeOfFont += sizeOfFont * 0.20
      }
    
      let textFont = UIFont.boldSystemFontOfSize(sizeOfFont)
      let nsString = badgeText as NSString
      let textSize = nsString.sizeWithAttributes([NSFontAttributeName: textFont])
      
      let point = CGPointMake(
        (rect.size.width / 2 - textSize.width / 2),
        (rect.size.height / 2 - textSize.height / 2))
    
      nsString.drawAtPoint(point, withAttributes: [
        NSForegroundColorAttributeName: badgeTextColor,
        NSFontAttributeName: textFont]
      )
    }
  }
}
