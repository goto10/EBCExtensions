//
//  EBC_StringExtentions.swift
//  NotifyMe
//
//  Created by Mike Anelli on 1/10/15.
//  Copyright (c) 2015 8BitCode. All rights reserved.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let regex = NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, count(self))) != nil
    }
    
    func isValidURL() -> Bool {
        
        let candidateURL = NSURL(string: self)

        if candidateURL != nil && candidateURL?.host != nil {
            return true
        } else {
            return false
        }

        
    }
    
    func addDropShadow(shadowOffset offset: CGSize) -> NSAttributedString {
        
        var attString = NSMutableAttributedString(string: self)
        
        var shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = 3.0
        attString.addAttributes([NSShadowAttributeName: shadow], range: NSMakeRange(0, attString.length))
        
        return attString
        
    }
    
    func lastNCharacters(n: Int) -> String? {

        var substring:String?
        let index = self.length - n
        
        if index > 0 {
            substring = self.substringFromIndex(advance(self.startIndex, index))
        }

        return substring
        
    }
}

