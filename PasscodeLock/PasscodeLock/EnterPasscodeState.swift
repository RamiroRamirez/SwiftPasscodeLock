//
//  EnterPasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public let PasscodeLockIncorrectPasscodeNotification = "passcode.lock.incorrect.passcode.notification"

struct EnterPasscodeState		: PasscodeLockStateType {
    
    let title					: String
    let description				: String
    let isCancellableAction		: Bool
    var isTouchIDAllowed 		= true
    
    private var inccorectPasscodeAttempts = 0
    private var isNotificationSent = false
    
	init(allowCancellation: Bool = false, stringsToShow: StringsToBeDisplayed?) {

        isCancellableAction = allowCancellation
        title = (stringsToShow?.passcodeLockEnterTitle ?? localizedStringFor("PasscodeLockEnterTitle", comment: "Enter passcode title"))
        description = (stringsToShow?.passcodeLockEnterDescription ?? localizedStringFor("PasscodeLockEnterDescription", comment: "Enter passcode description"))
    }
    
	mutating func acceptPasscode(passcode: [String], fromLock lock: PasscodeLockType, stringsToShow: StringsToBeDisplayed?) {
        
        guard let currentPasscode = lock.repository.passcode else {
            return
        }
        
        if (passcode == currentPasscode) {
            lock.delegate?.passcodeLockDidSucceed(lock)
            
        } else {
            
            inccorectPasscodeAttempts += 1
            if (inccorectPasscodeAttempts >= lock.configuration.maximumInccorectPasscodeAttempts) {
                postNotification()
            }
            lock.delegate?.passcodeLockDidFail(lock)
        }
    }
    
    private mutating func postNotification() {
        
        guard (isNotificationSent == false) else {
			return
		}
            
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(PasscodeLockIncorrectPasscodeNotification, object: nil)
        isNotificationSent = true
    }
}
