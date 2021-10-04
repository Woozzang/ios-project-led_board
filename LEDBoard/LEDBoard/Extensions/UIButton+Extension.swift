//
//  UIButton+Extensions.swift
//  LEDBoard
//
//  Created by Woochan Park on 2021/10/04.
//

import UIKit

extension UIButton {
  
  private var customDefinedHorizontalPadding: CGFloat {
    get {
      return 24
    }
  }
  
  open override var intrinsicContentSize: CGSize {
  
    get {
      let baseSize = super.intrinsicContentSize
      
      return CGSize(width: baseSize.width + (customDefinedHorizontalPadding * 2),
                    height: baseSize.height)
    }
  }
}
