//
//  IgnoreFile.swift
//  R.swift
//
//  Created by Mathijs Kadijk on 01-10-16.
//  Copyright © 2016 Mathijs Kadijk. All rights reserved.
//

import Foundation

class IgnoreFile {
  private let patterns: [String]
  
  init() {
    patterns = []
  }

  init(ignoreFileURL: URL) throws {
    let ignoreFileParentPath = ignoreFileURL.baseURL?.absoluteString ?? ""
    patterns = try String(contentsOf: ignoreFileURL)
      .components(separatedBy: CharacterSet.newlines)
      .filter(IgnoreFile.isPattern)
      .map { ignoreFileParentPath + $0 }
  }

  static private func isPattern(potentialPattern: String) -> Bool {
    // Check for empty line
    if potentialPattern.characters.count == 0 { return false }

    // Check for commented line
    if potentialPattern.characters.first == "#" { return false }

    return true
  }

  func match(url: NSURL) -> Bool {
    var globObj = glob_t()
    
    var paths = [String]()
    
    glob(
      "/Users/isogai_yoshinori/**/*.txt",
      0,
      nil,
      &globObj
    )
    
    for i in 0 ..< Int(globObj.gl_matchc) {
      let path = String.init(describing: globObj.gl_pathv[i]!)
      paths.append(path)
    }
    
    print(paths)
    
    globfree(&globObj)
    
    
    return patterns
      .map { NSURL.init(string: $0) }
      .any { url == $0 }
  }
}
