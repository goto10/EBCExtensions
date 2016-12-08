//
//  EBC_ArrayExtentions.swift
//  NotifyMe
//
//  Created by Mike Anelli on 5/21/15.
//  Copyright (c) 2015 8BitCode. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
 
    mutating func removeObject(object: Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
}
