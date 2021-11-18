//
//  MissionAstronautsView.swift
//  Moonshot
//
//  Created by Leonardo  on 18/11/21.
//

import SwiftUI

struct MissionAstronautsView: View {
  let mission: Mission
  let crew: [CrewMember]

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        /// # The `id` must be a `simple type: String, int, etc`, not a `struct`
        ForEach(crew, id: \.role) { crewMember in
          NavigationLink {
            AstronautView(astronaut: crewMember.astronaut, role: crewMember.role)
          } label: {
            VStack {
              Image(crewMember.astronaut.id)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 320)
                /// # `Clipping` the image (Cropping) removes excessive length
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                /// # `strokeBorder` makes the border take space from the View itself
                /// # `stroke` makes the border 50% inside and 50% outside
                // .overlay(RoundedRectangle(cornerRadius: 15).strokeBorder(Color.white, lineWidth: 1))
                .shadow(color: Color.white, radius: 5)
              Text(crewMember.astronaut.name)
                .foregroundColor(Color.white)
                .font(.headline)
              Text(crewMember.role)
                .foregroundColor(Color.secondary)
            }
            .padding()
          }
        }
      }
    }
  }

  init(mission: Mission, astronauts: [String: Astronaut]) {
    self.mission = mission
    /// # `map` generates a new array that can be used afterwards
    /// # `forEach` doesn't return anything, it's `void`
    self.crew = mission.crew.map { member in
      if let astronaut = astronauts[member.name] {
        return CrewMember(role: member.role, astronaut: astronaut)
      } else {
        fatalError("Missing \(member.name)")
      }
    }
  }
}
