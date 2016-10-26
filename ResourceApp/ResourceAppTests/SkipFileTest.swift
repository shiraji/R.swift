//
//  SkipFileTest.swift
//  ResourceApp
//
//  Created by Yoshinori Isogai on 2016/10/27.
//  Copyright © 2016年 Mathijs Kadijk. All rights reserved.
//

import UIKit
import XCTest
import Rswift
@testable import ResourceApp

class SkipFileTest: XCTestCase {
  
  func testSkyTiff() {
    let imageMirror = Mirror(reflecting: R.image.self)
    
    imageMirror.children.forEach { print("\($0.label!) => \($0.value)") }
    
  }
}
