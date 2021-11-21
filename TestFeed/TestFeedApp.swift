//
//  TestFeedApp.swift
//  TestFeed
//
//  Created by Ilya Matveev on 21.11.2021.
//

import SwiftUI

@main
struct TestFeedApp: App {
    var body: some Scene {
        WindowGroup {
            FeedView(model: .init())
                .background(Color.white)
        }
    }
}
