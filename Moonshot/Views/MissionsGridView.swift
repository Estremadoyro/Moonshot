//
//  MissionsGridView.swift
//  Moonshot
//
//  Created by Leonardo  on 18/11/21.
//

import SwiftUI

struct MissionsGridView: View {
  let astronauts: [String: Astronaut]
  let missions: [Mission]
  @ObservedObject var toolBarState: ToolbarState

  /// # `Adaptive` layout
  let columns = [
    GridItem(.adaptive(minimum: 180, maximum: .infinity))
  ]

  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: self.columns) {
        /// # Missions is @Identifiable so it doesn't need to specify an id
        ForEach(missions) { mission in
          NavigationLink {
            MissionView(mission: mission, astronauts: astronauts)
          } label: {
            VStack {
              Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
              VStack {
                Text(mission.displayName)
                  .font(.headline)
                  .foregroundColor(Color.white)
                /// # `mission.launchDate` is NOT `String`, it's a `Date` so it can't conform a `Text`
                Text(mission.formattedShortLaunchDate)
                  .font(.caption)
                  .foregroundColor(Color.white.opacity(0.5))
              }
              .padding(.vertical)
              /// # Will increate the width to fit the `GridItem's`
              .frame(maxWidth: .infinity)
              .background(Color.lightBackground)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.lightBackground))
            .toolbar {
              ToolbarItem {
                Button(action: {
                  withAnimation(.default) {
                    toolBarState.isGridStyle.toggle()
                  }
                }) {
                  Image(systemName: self.toolBarState.isGridStyle ? "list.bullet" : "square.grid.2x2")
                }
              }
            }
          }
        }
      }
      .padding([.horizontal, .bottom])
    }
    .navigationTitle("Moonshot")
    /// # We must specify the bg witll `ignoreSafeArea`
    .background(Color.darkBackground.ignoresSafeArea())
    /// # Set the views theme
    .preferredColorScheme(.dark)
  }
}
