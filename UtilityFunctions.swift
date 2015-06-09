//
//  UtilityFunctions.swift
//  NotifyMe
//
//  Created by Mike Anelli on 4/28/15.
//  Copyright (c) 2015 8BitCode. All rights reserved.
//

import Foundation

class Utility{
    class func classNameAsString(obj: Any) -> String {
        //prints more readable results for dictionaries, arrays, Int, etc
        return _stdlib_getDemangledTypeName(obj).componentsSeparatedByString(".").last!
    }
}
