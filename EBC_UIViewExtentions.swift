//
//  EBC_UIViewExtentions.swift
//  NotifyMe
//
//  Created by Mike Anelli on 4/4/15.
//  Copyright (c) 2015 8BitCode. All rights reserved.
//

import Foundation

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}
