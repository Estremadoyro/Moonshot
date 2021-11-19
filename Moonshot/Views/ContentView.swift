//
//  ContentView.swift
//  Moonshot
//
//  Created by Leonardo  on 14/11/21.
//

import SwiftUI

struct ContentView: View {
  /// # `decode` is now generic, meaning `astronauts` doesn't have an implicit or explicit `type`
  /// # To solve this, we must give it an `explicit` type
  let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json") ///
  let missions: [Mission] = Bundle.main.decode("missions.json")

  /// # `Toolbar` state
  @StateObject var toolBarState = ToolbarState()

  var body: some View {
    NavigationView {
      Group {
        if toolBarState.isGridStyle {
          MissionsGridView(astronauts: astronauts, missions: missions, toolBarState: toolBarState)
        }
        else if !toolBarState.isGridStyle {
          MissionsListView(astronauts: astronauts, missions: missions, toolBarState: toolBarState)
        }
      }
    }
    .preferredColorScheme(.dark)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
