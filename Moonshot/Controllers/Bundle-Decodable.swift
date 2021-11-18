//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Leonardo  on 14/11/21.
//

import Foundation

extension Bundle {
  /// # The json contains astronauts objects identified by their name, thus a dictionary is convenient
  /// # If we want to `reuse` the code propertly, we must make it `Generic`, so the types can be specified when the method is invoked
  func decode<T: Codable>(_ file: String) -> T {
    /// # 1. Find the file in the Bundle
    /// Bundle.main.url = self.url
    /// For json is not necessary to specify the extension
    guard let dataURL = Bundle.main.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to locate \(file) in bundle.")
    }
    /// # 2. Load the file from Bundle
    /// Data() defines the type of data, it could be String if i'ts just lines with no structure
    guard let data = try? Data(contentsOf: dataURL) else {
      fatalError("Failed to load \(file) from bundle.")
    }
    /// # 3. Decode loaded file from Bundle
    /// The `generic` reference must conform `Decodable`
    /// # 3.1 Create a `date format`
    let decoder = JSONDecoder()
    /// Settings for formatting `String` (JSON) to `Date` type in `Swift` data types
    let formatter = DateFormatter()
    /// Where MM & dd represet 0-padding date formats
    formatter.dateFormat = "yyyy-MM-dd"
    /// You can also specify the timeZone, so the user's time zone doesn't interfere
    // formatter.timeZone
    /// Now pass in the date decoding strategy
    decoder.dateDecodingStrategy = .formatted(formatter)
    guard let dataLoaded = try? decoder.decode(T.self, from: data) else {
      fatalError("Failed to decode \(file) from bundle.")
    }
    print("Loaded: \(file)")
    return dataLoaded
  }
}
