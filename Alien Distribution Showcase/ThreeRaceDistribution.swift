//
//  viewModel.swift
//  Alien Distribution Showcase
//
//  Created by juheon yang on 15/03/2022.
//

import SwiftUI
import GameplayKit

class ThreeRaceDistribution: ObservableObject {
    static func distribution(mean: Float, standardDeviation: Float) -> GKGaussianDistribution {
        AlienBasic.distribution(mean: mean, standardDeviation: standardDeviation)
    }
    static func distribution(lowestValue: Int, highestValue: Int) -> GKGaussianDistribution {
        AlienBasic.distribution(lowestValue: lowestValue, highestValue: highestValue)
    }
    typealias Race = AlienBasic.Race
    typealias Alien = AlienBasic.Alien
    
    private static func alienBasicCreator() -> AlienBasic{
        AlienBasic()
    }
    
    @Published var alienBasic = alienBasicCreator()
    
    func generateRaces(races: [Race] = [], number: Int) {
        alienBasic.generateRaces(races: races, number: number)
    }
    func generateAliens(n: Int, races: [Race]) {
        alienBasic.generateAliens(n: n, races: races)
    }
    var races: [Race] {
        alienBasic.races
    }
    
    func alienRatio() -> (Double, Double, Double) {
        var raceOneCount = 0.0
        var raceTwoCount = 0.0
        var raceThreeCount = 0.0
        var alienCount = 0.0
        for alien in alienBasic.filteredPopulation(strictness: Int(alienBasic.strictness), intervalSizePercentage: alienBasic.intervalSizePercentage) {
            if alien.race == races[0] {
                raceOneCount += 1
            } else if alien.race == races[1] {
                raceTwoCount += 1
            } else {raceThreeCount += 1}
            alienCount += 1
        }
        return (100*raceOneCount/alienCount, 100*raceTwoCount/alienCount, 100*raceThreeCount/alienCount)
    }
        
    func changeStrictness(to newStrictness: Double) {
        alienBasic.changeStrictness(newStrictness: newStrictness)
        objectWillChange.send()
    }
    func changeIntervalSizePercentage(to newIntervalSizePercentage: Double) {
        alienBasic.changeIntervalSizePercentage(newIntervalSizePercentage: newIntervalSizePercentage)
        objectWillChange.send()
    }
    
    init() {
        generateRaces(number: 3)
        
        generateAliens(n: 10000, races: alienBasic.races)
//        let raceOne = Race(
//            antennaLengthDistribution: ThreeRaceDistribution.distribution(mean: 50, standardDeviation: 15),
//            legTorsoRatioDistribution: ThreeRaceDistribution.distribution(mean: 80, standardDeviation: 25),
//            heightDistribution: ThreeRaceDistribution.distribution(mean: 200, standardDeviation: 30),
//            rDistribution: ThreeRaceDistribution.distribution(lowestValue: 20, highestValue: 170),
//            gDistribution: ThreeRaceDistribution.distribution(lowestValue: 40, highestValue: 230),
//            bDistribution: ThreeRaceDistribution.distribution(lowestValue: 10, highestValue: 120),
//            eyeRadiusDistribution: ThreeRaceDistribution.distribution(mean: 90, standardDeviation: 30)
//        )
//        let raceTwo = Race(
//            antennaLengthDistribution: ThreeRaceDistribution.distribution(mean: 100, standardDeviation: 15),
//            legTorsoRatioDistribution: ThreeRaceDistribution.distribution(mean: 80, standardDeviation: 25),
//            heightDistribution: ThreeRaceDistribution.distribution(mean: 180, standardDeviation: 30),
//            rDistribution: ThreeRaceDistribution.distribution(lowestValue: 20, highestValue: 170),
//            gDistribution: ThreeRaceDistribution.distribution(lowestValue: 40, highestValue: 230),
//            bDistribution: ThreeRaceDistribution.distribution(lowestValue: 60, highestValue: 120),
//            eyeRadiusDistribution: ThreeRaceDistribution.distribution(mean: 110, standardDeviation: 30)
//        )
//        let raceThree = Race(
//            antennaLengthDistribution: ThreeRaceDistribution.distribution(mean: 50, standardDeviation: 15),
//            legTorsoRatioDistribution: ThreeRaceDistribution.distribution(mean: 80, standardDeviation: 25),
//            heightDistribution: ThreeRaceDistribution.distribution(mean: 200, standardDeviation: 30),
//            rDistribution: ThreeRaceDistribution.distribution(lowestValue: 20, highestValue: 170),
//            gDistribution: ThreeRaceDistribution.distribution(lowestValue: 40, highestValue: 230),
//            bDistribution: ThreeRaceDistribution.distribution(lowestValue: 10, highestValue: 120),
//            eyeRadiusDistribution: ThreeRaceDistribution.distribution(mean: 90, standardDeviation: 30)
//        )
//        alienBasic.generateRaces(races: [raceOne, raceTwo, raceThree], number: 3)
        
    }
}

extension AlienBasic.Race {
    func raceDescriptions(raceNumber: Int) -> String {
                    """
                    Race \(raceNumber):
                    Antenna Length Distribution:
                                Mean: \(self.antennaLengthDistribution.mean)
                                Standard Deviation: \(self.antennaLengthDistribution.deviation)
                    
                    Leg-Torso Ratio Distribution:
                                Mean: \(self.legTorsoRatioDistribution.mean)
                                Standard Deviation: \(self.legTorsoRatioDistribution.deviation)
                    
                    Height Distribution:
                                Mean: \(self.heightDistribution.mean)
                                Standard Deviation: \(self.heightDistribution.deviation)

                    R Distribution:
                                Mean: \(self.rDistribution.mean)
                                Standard Deviation: \(self.rDistribution.deviation)

                    G Distribution:
                                Mean: \(self.gDistribution.mean)
                                Standard Deviation: \(self.gDistribution.deviation)

                    B Distribution:
                                Mean: \(self.bDistribution.mean)
                                Standard Deviation: \(self.bDistribution.deviation)

                    Eye Radius Distribution:
                                Mean: \(self.eyeRadiusDistribution.mean)
                                Standard Deviation: \(self.eyeRadiusDistribution.deviation)
                    
                    """
    }
}
