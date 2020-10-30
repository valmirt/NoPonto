//
//  MeatTemperature.swift
//  NoPonto WatchKit Extension
//
//  Created by Valmir Junior on 29/10/20.
//

import Foundation

enum MeatTemperature: Int {
    case rare = 0, mediumRare, medium, wellDone
    
    var stringValue: String {
        let temperatures = ["Cru", "Mal passado", "Ao Ponto", "Bem Passado"]
        return temperatures [self.rawValue]
    }
    
    var timeModifier: Double {
        let modifiers = [0.5, 0.75, 1, 1.5]
        return modifiers[self.rawValue]
    }
    
    func cookTime(for kg: Double) -> TimeInterval {
        let baseTime: TimeInterval = 60 * 1.3
        let baseWeight = 0.5
        let weightModifier = kg / baseWeight
        return baseTime * weightModifier * self.timeModifier
    }
}
