//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Leonardo  on 14/11/21.
//

import Foundation
import SwiftUI

/// # `Color` conforms a bigger protocol `ShapeStyle`
/// # To create `Custom App Colors` we need to extend `ShapeStyle` but ONLY when is used as a `Color`
extension ShapeStyle where Self == Color {
  static var darkBackground: Color {
    return Color(red: 0.1, green: 0.1, blue: 0.2)
  }

  static var lightBackground: Color {
    return Color(red: 0.2, green: 0.2, blue: 0.3)
  }
}
