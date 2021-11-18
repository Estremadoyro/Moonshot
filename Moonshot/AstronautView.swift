//
//  AstronautView.swift
//  Moonshot
//
//  Created by Leonardo  on 17/11/21.
//

import SwiftUI

struct AstronautView: View {
  let astronaut: Astronaut
  var body: some View {
    ScrollView {
      VStack {
        Image(astronaut.id)
          .resizable()
          .scaledToFit()
          .clipShape(RoundedRectangle(cornerRadius: 15))
          .shadow(color: Color.white, radius: 5)
          .padding([.horizontal, .top])

        VStack(alignment: .leading) {
          Rectangle()
            .frame(height: 2)
            .foregroundColor(Color.lightBackground)
            .padding(.vertical)
          Text(astronaut.name)
            .font(.title.bold())
          Text(astronaut.description)
        }
        .padding()
      }
    }
    .navigationTitle(astronaut.name)
    .navigationBarTitleDisplayMode(.inline)
    .background(Color.darkBackground.ignoresSafeArea())
  }
}
