//
//  ContentView.swift
//  Alien Distribution Showcase
//
//  Created by juheon yang on 15/03/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var distribution: ThreeRaceDistribution
    @State private var strictness = 7.0
    @State private var intervalSizePercentage = 100.0
    var body: some View {
        VStack {
            Slider(
                value: $strictness,
                in: 1...7,
                step: 1
            ) {
                Text("Strictness")
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("7")
            } onEditingChanged: {_ in
                distribution.changeStrictness(to: strictness)
            }
            Text("\(Int(strictness))")
            
            Slider(
                value: $intervalSizePercentage,
                in: 0...100,
                step: 1
            ) {
                Text("Interval Size")
            } minimumValueLabel: {
                Text("0%")
            } maximumValueLabel: {
                Text("100%")
            } onEditingChanged: {_ in
                distribution.changeIntervalSizePercentage(to: intervalSizePercentage/100.0)
            }
            Text("\(Int(intervalSizePercentage))")
                        
            let alienRatio = distribution.alienRatio()
            Text("\(alienRatio.0) : \(alienRatio.1) : \(alienRatio.2)").font(.title)
            
            Spacer()
            
            HStack {
                AlienDataChart(race: distribution.races[0], raceNumber: 1)
                Spacer()
                AlienDataChart(race: distribution.races[1], raceNumber: 2)
                Spacer()
                AlienDataChart(race: distribution.races[2], raceNumber: 3)
            }
        .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(distribution: ThreeRaceDistribution())
                .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        }
    }
}

