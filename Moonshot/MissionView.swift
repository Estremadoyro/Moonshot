//
//  MissionView.swift
//  Moonshot
//
//  Created by Leonardo  on 14/11/21.
//

import SwiftUI

struct CrewMember {
  let role: String
  let astronaut: Astronaut
}

struct MissionView: View {
  let crew: [CrewMember]
  let mission: Mission

  var body: some View {
    GeometryReader { geo in
      ScrollView(.vertical) {
        VStack {
          Image(mission.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geo.size.width * 0.6)
            .padding(.vertical)
          VStack(alignment: .leading) {
            Rectangle()
              .frame(height: 2)
              .foregroundColor(Color.lightBackground)
              .padding(.vertical)
            Text("Mission Highlights")
              .font(.title.bold())
              .padding(.bottom, 5)
            /// # The length of the `description` fill the entire width, until now the image and title were `not vertically aligned`
            Text(mission.description)
            Rectangle()
              .frame(height: 2)
              .foregroundColor(Color.lightBackground)
              .padding(.vertical)
            Text("Crew")
              .font(.title.bold())
          }
          .padding(.horizontal)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              /// # The `id` must be a `simple type: String, int, etc`, not a `struct`
              ForEach(crew, id: \.role) { crewMember in
                NavigationLink {
                  AstronautView(astronaut: crewMember.astronaut)
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
        .padding(.bottom)
      }
    }
    /// # The `nagivationTitle` is the label of the `NavigationLink`
    .navigationTitle(mission.displayName)
    /// # Make the `navigationTitle` size smaller
    .navigationBarTitleDisplayMode(.inline)
    .background(Color.darkBackground.ignoresSafeArea())
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

struct MissionView_Preview: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
  static var previews: some View {
    MissionView(mission: missions[0], astronauts: astronauts)
      .preferredColorScheme(.dark)
  }
}
