//
//  EBC_StringExtentions.swift
//  NotifyMe
//
//  Created by Mike Anelli on 1/10/15.
//  Copyright (c) 2015 8BitCode. All rights reserved.
//

import UIKit

extension String {
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: [.CaseInsensitive])
        return regex.firstMatchInString(self, options: [], range: NSMakeRange(0, utf16.count)) != nil
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
        
        let attString = NSMutableAttributedString(string: self)
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = 3.0
        attString.addAttributes([NSShadowAttributeName: shadow], range: NSMakeRange(0, attString.length))
        
        return attString
        
    }
    
    func lastNCharacters(n: Int) -> String? {

        var substring:String?
        let index = self.characters.count - n
        
        if index > 0 {
            let startIndex = self.endIndex.advancedBy(n * -1)
            substring = self.substringFromIndex(startIndex)
        }

        return substring
        
    }
}

