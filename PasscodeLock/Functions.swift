//
//  Functions.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

func localizedStringFor(key: String, comment: String) -> String {
    
    let name = "Localize"
    let bundle = bundleForResource(name, ofType: "strings")
    
    return NSLocalizedString(key, tableName: name, bundle: bundle, comment: comment)
}

func bundleForResource(name: String, ofType type: String) -> NSBundle {
    
    if(NSBundle.mainBundle().pathForResource(name, ofType: type) != nil) {
        return NSBundle.mainBundle()
    }
    
    return NSBundle(forClass: PasscodeLock.self)
}

func defaultCustomColor() -> UIColor {
	return UIColor(red: 0, green: 100/255, blue: 165/255, alpha: 1)
}
