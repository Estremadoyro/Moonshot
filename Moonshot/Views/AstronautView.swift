//
//  AstronautView.swift
//  Moonshot
//
//  Created by Leonardo  on 17/11/21.
//

import SwiftUI

extension Image {
  func applyAstronautImageStyle() -> some View {
    return self
      .resizable()
      .scaledToFit()
      .clipShape(RoundedRectangle(cornerRadius: 15))
      .shadow(color: Color.white, radius: 5)
      .padding([.horizontal, .top])
  }
}

struct AstronautView: View {
  let astronaut: Astronaut
  let role: String

  var body: some View {
    ScrollView {
      VStack {
        Image(astronaut.id)
          .applyAstronautImageStyle()

        VStack(alignment: .leading) {
          CustomSeparatorView()
          Text(astronaut.name)
            .font(.title.bold())
          Text(astronaut.description)
        }
        .padding()
      }
    }
    .navigationTitle(self.role)
    .navigationBarTitleDisplayMode(.inline)
    .background(Color.darkBackground.ignoresSafeArea())
  }
}
