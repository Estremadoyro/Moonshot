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

  /// # `Adaptive` layout
  let columns = [
    GridItem(.adaptive(minimum: 180, maximum: .infinity))
  ]

  var body: some View {
    NavigationView {
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
}
