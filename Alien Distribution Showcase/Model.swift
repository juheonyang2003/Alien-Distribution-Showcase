//
//  Model.swift
//  Alien Distribution Showcase
//
//  Created by juheon yang on 15/03/2022.
//
import GameplayKit
import SwiftUI

class AlienBasic {
        
    private static let random = GKRandomSource()
    
    static func distribution(mean: Float, standardDeviation: Float) -> GKGaussianDistribution {
        GKGaussianDistribution(randomSource: random, mean: mean, deviation: standardDeviation)
    }
    static func distribution(lowestValue: Int, highestValue: Int) -> GKGaussianDistribution {
        GKGaussianDistribution(randomSource: random, lowestValue: lowestValue, highestValue: highestValue)
    }
    static func distribution(estimatedMean: Float, estimatedSD: Float) -> GKGaussianDistribution {
        let meanMaxVariability: Float = 0.2
        let sdMaxVariability: Float = 0.2
        
        let mean = (estimatedMean * Float.random(in: 1 - meanMaxVariability...1 + meanMaxVariability)).rounded(.towardZero)
        let standardDeviation = (estimatedSD * Float.random(in: 1 - sdMaxVariability...1 + sdMaxVariability)).rounded(.towardZero)
        return distribution(mean: mean, standardDeviation: standardDeviation)
    }

    struct Race: Equatable {
        var antennaLengthDistribution: GKGaussianDistribution
        var legTorsoRatioDistribution: GKGaussianDistribution
        var heightDistribution: GKGaussianDistribution
        var rDistribution: GKGaussianDistribution
        var gDistribution: GKGaussianDistribution
        var bDistribution: GKGaussianDistribution
        var eyeRadiusDistribution: GKGaussianDistribution
        
    }
    
    //use enum
    
    class Feature {
        
        var value: Double
        
        let distribution: GKGaussianDistribution
        
        func isPreferable(at beautyStandard: Double, sizePercentage: Double, limits: (lowestValue: Double, highestValue: Double)) -> Bool{
            let standardWithinLimits = min(max(limits.lowestValue, beautyStandard), limits.highestValue)
            let length = max(limits.highestValue - standardWithinLimits, standardWithinLimits - limits.lowestValue) * sizePercentage
            return value > standardWithinLimits - length && value <= standardWithinLimits + length
        }
        
        init(distribution: GKGaussianDistribution, decimalPlace: Int = 0, isFirstGeneration: inout Bool, limits: inout (lowestValue: Double, highestValue: Double)) {
            self.distribution = distribution
            value = distribution.nextDouble(decimalPlace: 2)
            
            if isFirstGeneration {
                limits = (Double(distribution.lowestValue), Double(distribution.highestValue))
                isFirstGeneration = false
            } else {
                if Double(distribution.lowestValue) < limits.lowestValue {
                    limits.lowestValue = Double(distribution.lowestValue)
                }
                if Double(distribution.highestValue) > limits.highestValue {
                    limits.highestValue = Double(distribution.highestValue)
                }
            }
        }
    }
    
    class AntennaLengthInCm: Feature {
        typealias Feature = AlienBasic.AntennaLengthInCm
        private static var limits: (lowestValue: Double, highestValue: Double) = (0, 0)
        private static var isFirstGeneration = true
        func isPreferable(at beautyStandard: inout Double, sizePercentage: Double) -> Bool {
            isPreferable(at: beautyStandard, sizePercentage: sizePercentage, limits: Feature.limits)
        }
        init(distribution: GKGaussianDistribution, decimalPlace: Int = 0) {
            super.init(distribution: distribution, isFirstGeneration: &Feature.isFirstGeneration, limits: &Feature.limits)
        }
    }
    class LegTorsoRatioTimes100: Feature {
        typealias Feature = AlienBasic.LegTorsoRatioTimes100
        private static var limits: (lowestValue: Double, highestValue: Double) = (0, 0)
        private static var isFirstGeneration = true
        func isPreferable(at beautyStandard: inout Double, sizePercentage: Double) -> Bool {
            isPreferable(at: beautyStandard, sizePercentage: sizePercentage, limits: Feature.limits)
        }
        init(distribution: GKGaussianDistribution, decimalPlace: Int = 0) {
            super.init(distribution: distribution, isFirstGeneration: &Feature.isFirstGeneration, limits: &Feature.limits)
        }
    }
    class Height: Feature {
        typealias Feature = AlienBasic.Height
        private static var limits: (lowestValue: Double, highestValue: Double) = (0, 0)
        private static var isFirstGeneration = true
        func isPreferable(at beautyStandard: inout Double, sizePercentage: Double) -> Bool {
            isPreferable(at: beautyStandard, sizePercentage: sizePercentage, limits: Feature.limits)
        }
        init(distribution: GKGaussianDistribution, decimalPlace: Int = 0) {
            super.init(distribution: distribution, isFirstGeneration: &Feature.isFirstGeneration, limits: &Feature.limits)
        }
    }
    class RValue: Feature {
        typealias Feature = AlienBasic.RValue
        private static var limits: (lowestValue: Double, highestValue: Double) = (0, 0)
        private static var isFirstGeneration = true
        func isPreferable(at beautyStandard: inout Double, sizePercentage: Double) -> Bool {
            isPreferable(at: beautyStandard, sizePercentage: sizePercentage, limits: Feature.limits)
        }
        init(distribution: GKGaussianDistribution, decimalPlace: Int = 0) {
            super.init(distribution: distribution, isFirstGeneration: &Feature.isFirstGeneration, limits: &Feature.limits)
            value = max(min(value, 255), 0)
        }
    }
    class GValue: Feature {
        typealias Feature = AlienBasic.GValue
        private static var limits: (lowestValue: Double, highestValue: Double) = (0, 0)
        private static var isFirstGeneration = true
        func isPreferable(at beautyStandard: inout Double, sizePercentage: Double) -> Bool {
            isPreferable(at: beautyStandard, sizePercentage: sizePercentage, limits: Feature.limits)
        }
        init(distribution: GKGaussianDistribution, decimalPlace: Int = 0) {
            super.init(distribution: distribution, isFirstGeneration: &Feature.isFirstGeneration, limits: &Feature.limits)
            value = max(min(value, 255), 0)
        }
    }
    class BValue: Feature {
        typealias Feature = AlienBasic.BValue
        private static var limits: (lowestValue: Double, highestValue: Double) = (0, 0)
        private static var isFirstGeneration = true
        func isPreferable(at beautyStandard: inout Double, sizePercentage: Double) -> Bool {
            isPreferable(at: beautyStandard, sizePercentage: sizePercentage, limits: Feature.limits)
        }
        init(distribution: GKGaussianDistribution, decimalPlace: Int = 0) {
            super.init(distribution: distribution, isFirstGeneration: &Feature.isFirstGeneration, limits: &Feature.limits)
            value = max(min(value, 255), 0)
        }
    }
    class EyeRadius: Feature {
        typealias Feature = AlienBasic.EyeRadius
        private static var limits: (lowestValue: Double, highestValue: Double) = (0, 0)
        private static var isFirstGeneration = true
        func isPreferable(at beautyStandard: inout Double, sizePercentage: Double) -> Bool {
            isPreferable(at: beautyStandard, sizePercentage: sizePercentage, limits: Feature.limits)
        }
        init(distribution: GKGaussianDistribution, decimalPlace: Int = 0) {
            super.init(distribution: distribution, isFirstGeneration: &Feature.isFirstGeneration, limits: &Feature.limits)
        }
    }
    
//MARK: figure out the initializer
    

    struct Alien {
        let race: Race
        let antennaLengthInCm: AntennaLengthInCm
        let legTorsoRatioTimes100: LegTorsoRatioTimes100
        let height: Height
        let rValue: RValue
        let gValue: GValue
        let bValue: BValue
        let eyeRadius: EyeRadius
        var color: Color {Color(red: rValue.value, green: gValue.value, blue: bValue.value)}
        init (race: Race) {
            self.race = race
            self.antennaLengthInCm = AntennaLengthInCm(distribution: race.antennaLengthDistribution)
            self.legTorsoRatioTimes100 = LegTorsoRatioTimes100(distribution: race.legTorsoRatioDistribution)
            self.height = Height(distribution: race.heightDistribution)
            self.rValue = RValue(distribution: race.rDistribution)
            self.gValue = GValue(distribution: race.gDistribution)
            self.bValue = BValue(distribution: race.bDistribution)
            self.eyeRadius = EyeRadius(distribution: race.eyeRadiusDistribution)
        }
    }
    
    private(set) var races: [Race] = []
    private(set) var population: [Alien] = []
    
    func generateRaces(races: [Race] = [], number: Int) {
        if number > 0 {
            if !races.isEmpty {
                self.races.append(contentsOf: races[0...min(number, races.count) - 1])
            }
            for _ in 0..<number - races.count {
                self.races.append(Race(
                    antennaLengthDistribution: AlienBasic.distribution(estimatedMean: 100, estimatedSD: 10),
                    legTorsoRatioDistribution: AlienBasic.distribution(estimatedMean: 100, estimatedSD: 10),
                    heightDistribution: AlienBasic.distribution(estimatedMean: 200, estimatedSD: 20),
                    rDistribution: AlienBasic.distribution(estimatedMean: 220, estimatedSD: 10),
                    gDistribution: AlienBasic.distribution(estimatedMean: 140, estimatedSD: 10),
                    bDistribution: AlienBasic.distribution(estimatedMean: 50, estimatedSD: 10),
                    eyeRadiusDistribution: AlienBasic.distribution(estimatedMean: 80, estimatedSD: 8))
                )
            }
        }
    }

    func generateAliens(n: Int, races: [Race]) {
        for race in races {
            for _ in 0..<n {
                population.append(Alien(race: race))
            }
        }
    }
    
    struct Preferences {
        static var antennaLengthPreference = 100.0
        static var legTorsoRatioTimes100Preference = 100.0
        static var heightPreference = 200.0
        static var rValuePreference = 250.0
        static var gValuePreference = 140.0
        static var bValuePreference = 40.0
        static var eyeRadiusPreference = 80.0
    }
    
    func filteredPopulation(strictness: Int, intervalSizePercentage: Double) -> [Alien] {
        population.filter{
            ($0.antennaLengthInCm.isPreferable(at: &Preferences.antennaLengthPreference, sizePercentage: intervalSizePercentage) ? 1 : 0) +
            ($0.legTorsoRatioTimes100.isPreferable(at: &Preferences.legTorsoRatioTimes100Preference, sizePercentage: intervalSizePercentage) ? 1 : 0) +
            ($0.height.isPreferable(at: &Preferences.heightPreference, sizePercentage: intervalSizePercentage) ? 1 : 0) +
            ($0.rValue.isPreferable(at: &Preferences.rValuePreference, sizePercentage: intervalSizePercentage) ? 1 : 0) +
            ($0.gValue.isPreferable(at: &Preferences.gValuePreference, sizePercentage: intervalSizePercentage) ? 1 : 0) +
            ($0.bValue.isPreferable(at: &Preferences.bValuePreference, sizePercentage: intervalSizePercentage) ? 1 : 0) +
            ($0.eyeRadius.isPreferable(at: &Preferences.eyeRadiusPreference, sizePercentage: intervalSizePercentage) ? 1 : 0)
            >= strictness
        }
    }

    
    
    
    init() {

    }
    
    
    private(set) var strictness = 7.0
    private(set) var intervalSizePercentage = 1.0
    func changeStrictness(newStrictness: Double) {
        strictness = newStrictness
    }
    func changeIntervalSizePercentage(newIntervalSizePercentage: Double) {
        intervalSizePercentage = newIntervalSizePercentage
    }
    
}



extension GKGaussianDistribution {
    func nextDouble(decimalPlace: Int) -> Double{
        let power = pow(10.0, Double(decimalPlace))
        let distribution = GKGaussianDistribution(lowestValue: lowestValue * Int(power), highestValue: highestValue * Int(power))
        return Double(distribution.nextInt())/power
    }
}
