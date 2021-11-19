//
//  MissionsListView.swift
//  Moonshot
//
//  Created by Leonardo  on 18/11/21.
//

import SwiftUI

struct MissionsListView: View {
  let astronauts: [String: Astronaut]
  let missions: [Mission]
  @ObservedObject var toolBarState: ToolbarState

  var body: some View {
    ZStack {
      Color.darkBackground.ignoresSafeArea()
      List(missions) { mission in
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
        .listRowBackground(Color.darkBackground)
      }
      .navigationTitle("Moonshot")
      .listStyle(.plain)
    }
  }
}
