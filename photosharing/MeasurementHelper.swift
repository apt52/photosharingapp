//
//  MeasurementHelper.swift
//  photosharing
//
//  Created by Rohan Desai on 6/4/16.
//  Copyright © 2016 rd. All rights reserved.
//

import Foundation
import Firebase

class MeasurementHelper: NSObject {
    
    static func sendLoginEvent() {
        FIRAnalytics.logEventWithName(kFIREventLogin, parameters: nil)
    }
    
    static func sendLogoutEvent() {
        FIRAnalytics.logEventWithName("logout", parameters: nil)
    }
    
//    static func sendMessageEvent() {
//        FIRAnalytics.logEventWithName("message", parameters: nil)
//    }
}