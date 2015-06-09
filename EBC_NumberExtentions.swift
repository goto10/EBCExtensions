//
//  EBC_NumberExtentions.swift
//  NotifyMe
//
//  Created by Mike Anelli on 3/10/15.
//  Copyright (c) 2015 8BitCode. All rights reserved.
//

import Foundation

extension Double {

    func milesToMeters() -> Double {
        return self * 1609.344
    }

    func metersToKilometers() -> Double {
        return self * 0.001
    }
    
    func metersToMiles() -> Double {
        return self * 0.000621371
    }
    
    func metersToFeet() -> Double {
        return self * 3.2808399
    }

    func metersToYards() -> Double {
        return self * 1.0936133
    }
    
    func shortDescription(precision: Int) -> String {
        
        let suffix = ["", "K", "M", "G", "T", "P", "E"]
        var value = self
        var index = 0
        
        while (value > 1000) {
            index++
            value /= 1000
        }
        
        return String(format: "%.\(precision)f%@", value, suffix[index])
    }
    
}