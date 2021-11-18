//
//  Mission.swift
//  Moonshot
//
//  Created by Leonardo  on 14/11/21.
//

import Foundation

struct Mission: Codable, Identifiable {
  /// # We can nest `CrewRole` because it's parte of a `Mission`, and itself alone has no meaning
  struct CrewRole: Codable {
    let name: String
    let role: String
  }

  /// # Represents the `apollo` number
  let id: Int
  /// # Make it a date so it can be converted when decoded
  let launchDate: Date?
  let crew: [CrewRole]
  let description: String
  var displayName: String {
    return "Apollo \(id)"
  }

  var image: String {
    return "apollo\(id)"
  }

  var formattedLaunchDate: String {
    /// # With guard, `unwrappedLaunchDate` can be used outside the if/else scope
    guard let unwrappedLaunchDate = launchDate else {
      return "N/A"
    }
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: unwrappedLaunchDate)
  }
}
