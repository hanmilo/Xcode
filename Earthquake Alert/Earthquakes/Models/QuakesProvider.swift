//
//  QuakesProvider.swift
//  Earthquakes-iOS
//
//  Created by Dean on 24/3/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

@MainActor
class QuakesProvider: ObservableObject {
    
    @Published var quakes: [Quake] = []
    
    private let client: QuakeClient
    
    func fetchQuakes() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuakes(atOffsets offsets: IndexSet) {
        quakes.remove(atOffsets: offsets)
    }
    
    func location(for quake: Quake) async throws -> QuakeLocation {
        return try await client.quakeLocation(from: quake.detail)
    }
    
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}