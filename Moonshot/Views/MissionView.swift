//
//  MissionView.swift
//  Moonshot
//
//  Created by Leonardo  on 14/11/21.
//

import SwiftUI

struct MissionView: View {
  let mission: Mission
  let astronauts: [String: Astronaut]

  var body: some View {
    GeometryReader { geo in
      ScrollView(.vertical) {
        VStack {
          Image(mission.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geo.size.width * 0.6)
            .padding(.vertical)
          Text(mission.formattedLongLaunchDate)
            .font(.title)
            .foregroundColor(Color.white.opacity(0.5))
          VStack(alignment: .leading) {
            CustomSeparatorView()
            Text("Mission Highlights")
              .font(.title.bold())
              .padding(.bottom, 5)
            /// # The length of the `description` fill the entire width, until now the image and title were `not vertically aligned`
            Text(mission.description)
            CustomSeparatorView()
            Text("Crew")
              .font(.title.bold())
          }
          .padding(.horizontal)
          MissionAstronautsView(mission: self.mission, astronauts: self.astronauts)
        }
        .padding(.bottom)
      }
    }
    /// # The `nagivationTitle` is the label of the `NavigationLink`
    .navigationTitle(mission.displayName)
    /// # Make the `navigationTitle` size smaller
    .navigationBarTitleDisplayMode(.inline)
    .background(Color.darkBackground.ignoresSafeArea())
  }
}
