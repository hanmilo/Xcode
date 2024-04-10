//
//  QuakeDetail.swift
//  Earthquakes-iOS
//
//  Created by Dean on 24/3/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct QuakeDetail: View {
    var quake: Quake
    @EnvironmentObject private var quakesProvider: QuakesProvider
    @State private var location: QuakeLocation? = nil
    
    var body: some View {
        VStack {
            if let location = self.location {
                QuakeDetailMap(location: location, tintColor: quake.color)
                    .ignoresSafeArea(.container)
            }
            QuakeMagnitude(quake: quake)
            Text(quake.place)
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted(date: .long, time: .standard))")
                .foregroundStyle(Color.secondary)
//Below: To review .onTapGesture experiment
//            var Tappy: Bool = false
                if let location = self.location {
//                    if Tappy == false {
                        Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
                        Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
//                    }
//                    else {
//                        Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(6))))")
//                        Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(6))))")
//                    } 
                }
        }
        .task {
            if self.location == nil {
                if let quakeLocation = quake.location {
                    self.location = quakeLocation
                } else {
                    self.location = try? await quakesProvider.location(for: quake)
                }
            }
        }
    }
}

//#Preview {
    struct QuakeDetail_Previews: PreviewProvider {
        static var previews: some View {
            QuakeDetail(quake: Quake.preview)
        }
    }
//}
