//
//  Alien_Distribution_ShowcaseApp.swift
//  Alien Distribution Showcase
//
//  Created by juheon yang on 15/03/2022.
//

import SwiftUI

@main
struct Alien_Distribution_ShowcaseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(distribution: ThreeRaceDistribution())
        }
    }
}
