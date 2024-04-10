//
//  TestDownloader.swift
//  Earthquakes-iOS
//
//  Created by Dean on 24/3/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
//        fatalError("Unimplemented")
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testQuakesData
    }
}
